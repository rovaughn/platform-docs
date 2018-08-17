Completely migrate a cluster to another cluster
===============================================

This guide will help you push your
existing project including data of the existing cluster into a new one. After
following this you will have a cluster with an exact replica of your source
cluster including data.

.. note::

   The new cluster will have a different ``hasura-app.io`` domain from the source.

.. note::

   This guide only applies to migration from a cluster on platform version
   ``0.15.x`` to another cluster on version ``0.15.x``.

We'll call the new cluster as 'destination cluster' (dst) and the existing cluster as
'source cluster' (src), since we are migrating from source to destination.

1. Create a new cluster
-----------------------

Create a new cluster by following :doc:`this <../cluster/create>`.

.. note::

    Ignore this step if you already have a cluster you want to migrate to.

2. Add the new cluster to your project
--------------------------------------

Add the newly created cluster to your project. From the project directory,
execute the command:

.. code::

   hasura cluster add <dst-cluster-name> -c <dst-cluster-alias>

3. Migrate Postgres data
------------------------

Next, we need to migrate all data from postgres on the source cluster to postgres on
the destination cluster. Hasura stores all data in a database called ``hasuradb``.

Before starting any data dump, put Postgres on the source cluster in read-only
mode, so that no new writes happens while we're migrating the data: 

.. code::

   hasura -c <src-cluster-alias> \
          ms exec -n hasura postgres -- \
          psql -U admin -d hasuradb -c 'ALTER DATABASE hasuradb SET default_transaction_read_only = true;' 

Next, dump data and schema from this database:

.. code::

   hasura -c <src-cluster-alias> \
          ms exec -n hasura postgres -- \
          pg_dump -O -x -U postgres -d hasuradb -Fc -Z9 -f data.sql.compressed

Copy this file to your local machine:

.. code::

   hasura -c <src-cluster-alias> \
          ms cp hasura/postgres:/data.sql.compressed data.sql.compressed

Then copy it to the destination cluster:

.. code::

   hasura -c <dst-cluster-alias> \
          ms cp data.sql.compressed hasura/postgres:/data.sql.compressed

Restore the database on destination cluster:

.. code::

   hasura -c <dst-cluster-alias> \
          ms exec -n hasura postgres -- \
          pg_restore -U postgres -d hasuradb -x \
          --clean --single-transaction /data.sql.compressed

5. Copy the filestore data
--------------------------

Now we have to copy the filestore data, from the source cluster to the new cluster.

The following commands will dump the filestore data from the source cluster,
tar it, copy it into your local filesystem, copy it to the new cluster
and untar it.

.. code-block:: shell

    hasura -c <src-cluster-alias> ms exec filestore -n hasura -- tar -czf  /fs-data.tar.gz /var/lib/filestore/data
    hasura -c <src-cluster-alias> ms cp hasura/filestore:/fs-data.tar.gz fs-data.tar.gz
    hasura -c <dst-cluster-alias> ms cp fs-data.tar.gz hasura/filestore:/fs-data.tar.gz
    hasura -c <dst-cluster-alias> ms exec filestore -n hasura -- tar -xzf  /fs-data.tar.gz

``<src-cluster-alias>`` is the alias for the source cluster, and ``<dst-cluster-alias>`` is the alias for the new cluster.

.. note::

   If you are sure you have not used any filestore features, you can skip this step.


6. Update the secrets
---------------------

Finally, update the secrets from the source to the new cluster.

.. code-block:: shell

    hasura -c <src-cluster-alias> secrets list # get auth.admin.password
    hasura -c <dst-cluster-alias> secrets update auth.admin.password <auth-admin-password>

``<src-cluster-alias>`` is the alias for the source cluster, and ``<dst-cluster-alias>`` is the alias for the new cluster.
``<auth-admin-password>`` is obtained from the first command, in this step.

7. Restart microservices
------------------------

Restart data, auth and filestore:

.. code-block:: shell

   hasura ms restart data -n hasura -c <dst-cluster-alias>
   hasura ms restart auth -n hasura -c <dst-cluster-alias>
   hasura ms restart filestore -n hasura -c <dst-cluster-alias>

8. Git push
-----------

You can now git push your project to the new cluster, and it should be live!

.. code-block:: shell

   # commit required files
   $ git push <dst-cluster-alias> master

where ``<dst-cluster-alias>`` is the alias for the new cluster.

Use ``hasura ms ls -c <dst-cluster-alias>`` to see the new URLs.

(Optional) 9. Reset read-only mode for source cluster
-----------------------------------------------------

If you want to continue to use the old cluster, reset the read-only mode set on
Postgres:

.. code::

   hasura -c <src-cluster-alias> \
          ms exec -n hasura postgres -- \
          psql -U postgres -d hasuradb -c \
          'START TRANSACTION READ WRITE; ALTER DATABASE hasuradb SET default_transaction_read_only = false; COMMIT;'
