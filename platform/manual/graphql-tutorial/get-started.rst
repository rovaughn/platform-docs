Part I: Create a Hasura project and cluster
===========================================

A Hasura project is a directory (i.e. a code repo) that contains all the configuration files, the database
migrations, along with the source code and configuration of your custom microservices. This project directory should be
a git repo, so that you can ``git push hasura master`` to deploy everything in the repo to a Hasura cluster.


Create a 'hello-world' project
------------------------------

Run the following command:

.. code-block:: bash

   $ hasura clone hasura/hello-world

::

   Cloning project...
   ✓ Project cloned directory=<dir-path>/hello-world


This will 'clone' the `hasura/hello-world <https://hasura.io/hub/projects/hasura/hello-world>`_ project from
`hasura.io/hub <https://hasura.io/hub>`_ into your current directory.

.. admonition:: Note

   ``hasura/hello-world`` is a starter project that contains a few database migrations to add a sample schema and
   some sample data to let you start experimenting quickly.

   You can clone any project from the `hub <https://hasura.io/hub>`_ and use that as a starting point for your new project.

Understand the project structure
--------------------------------
A Hasura project has a particular directory structure and it has to be maintained strictly, else ``hasura CLI`` will not work
as expected.

Move to the project directory we just cloned.

Run the following command:

.. code-block:: bash

   $ cd hello-world


Every Hasura project follows the below structure:

.. code-block:: bash

   .
   ├── .hasura
   ├── hasura.yaml
   ├── clusters.yaml
   ├── conf
   │   ├── authorized-keys.yaml
   │   ├── auth.yaml
   │   ├── ci.yaml
   │   ├── domains.yaml
   │   ├── filestore.yaml
   │   ├── gateway.yaml
   │   ├── http-directives.conf
   │   ├── notify.yaml
   │   ├── postgres.yaml
   │   ├── routes.yaml
   │   └── session-store.yaml
   ├── migrations
   │   ├── <1504788327_create_table_user.down.yaml>
   │   ├── <1504788327_create_table_user.down.sql>
   │   ├── <1504788327_create_table_user.up.yaml>
   │   └── <1504788327_create_table_user.up.sql>
   └── microservices
       ├── <adminer>
       │   └── k8s.yaml
       └── <flask>
           ├── src/
           ├── k8s.yaml
           └── Dockerfile

.. note::

   In our ``hello-world`` project, the ``microservices`` directories will by empty right now

Read more about :doc:`../project/index`

Create a Hasura cluster
-----------------------

Now that we have a project, we need to have a Hasura cluster that will become the target of where this project is deployed.
As you can guess, each project can have multiple Hasura clusters as targets. This can be used to create different environments
like development, staging, production, etc.

Step 1: Create a Hasura cluster and add it to your project
----------------------------------------------------------

Install Hasura on a Kubernetes cluster by following these :doc:`guides <../install-hasura/index>` (*Minikube,
Docker for Desktop, Google Kubernetes Engine, etc.*). These guides also contain instructions on adding your cluster
to the Hasura project you cloned in the previous step (Note: use cluster alias as ``hasura`` while adding the cluster).

Step 2: Deploy the project to the cluster
-----------------------------------------

To deploy the project to the cluster, run the following:

.. code-block:: bash

   # Commit the project files and git push to deploy
   $ git add . && git commit -m "Initial commit"
   $ git push hasura master   # hasura is the cluster alias to deploy to


The ``git push`` will deploy everything, i.e. the project conf, migrations and microservices, to the cluster.

The Hasura cluster comes with a bunch of in-built microservices for database, authentication, files, routing etc. The GraphQL API is served by the data microservice.

Read more about :doc:`../cluster/index`


Next: GraphQL schema
--------------------

Next, let's head to :doc:`graphql-schema`.
