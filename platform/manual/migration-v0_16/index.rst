.. _upgrading-v0_16:

Upgrading to Hasura Platform v0.16 from v0.15
=============================================

Hasura Platform ``v0.16`` includes the open source `GraphQL Engine
<https://github.com/hasura/graphql-engine>`_. Hasura CLI ``v0.4`` onwards packs a
convenient command to make the migration easier.

Step 1: Install/Update Hasura CLI
---------------------------------

If you already have Hasura CLI installed, update it to the latest version:

.. code::

   hasura update-cli

If you don't have the CLI installed, you can find the installation instructions
at :ref:`install-cli`.

Step 2: Execute the upgrade command
-----------------------------------

Once inside a Hasura project directory with the required cluster added, execute
the following command:

.. code::

   hasura platform:upgrade -c <alias>

Replace alias with the alias of the cluster that needs to be upgraded.
The cluster will be upgraded to ``v0.16``.

Step 3: (Known issue) Modify permission rules
---------------------------------------------

Until a bug regarding variable names in permission rules with GraphQL Engine
(`hasura/graphql-engine#317
<https://github.com/hasura/graphql-engine/issues/317>`_) is fixed, a few extra
steps are required to get the latest platform version working.

Export graphql engine metadata:

.. code::

   hasura platform:metadata export

This will create a file called ``metadata.yaml`` inside ``migrations``
directory. Edit this file and replace all occurances of ``REQ_USER_ID`` with
``X-Hasura-User-Id`` (if any). Also replace all occurances in migration files.

.. code::

   # bash
   sed -i 's/REQ_USER_ID/X-Hasura-User-Id/' migrations/*.yaml

Apply the edited metadata:

.. code::

   hasura platform:metadata apply
