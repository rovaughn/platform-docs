.. _hub_start:

Starting with a project from /hub
=================================

Head to `platform.hasura.io/hub <https://platform.hasura.io/hub>`_ and choose a project that you want to start with.

Here are some useful projects to start with:

1. ``hasura/hello-*``: Projects that are published by the ``hasura`` user are projects that we have
   published for different frameworks to help you get started. See `Starter hub projects:`_
2. ``hasura/base``: Use the base project to start off on a completely empty project. You can add your
   own microservices, schemas and configurations to this.


Clone the project and deploy it to a new cluster
------------------------------------------------

First, :doc:`install <../install-hasura-cli>` the hasura CLI.

Then, run the following instructions on your terminal or command line:

.. code-block:: bash

   hasura clone <user/my-project>
   cd <my-project>

Now, you'll have the project source code on your computer. You now need a cluster to deploy this project.
Please see :doc:`this <../cluster/create>` for instructions on creating a new cluster and adding it to a
project. Once you've added the cluster to the project, run the following commands on your terminal or command
line, from inside the project directory:

.. code-block:: bash

   git add . && git commit -m 'Initial commit'
   
   # replace hasura with your cluster's alias
   git push hasura master
   
Once your `git push` succeeds, everything is deployed to a new Hasura cluster.

Now you can add/remove/modify:

1. microservices: In the ``microservices/`` directory
2. schema: Run ``hasura api-console`` and head to the ``Data`` tab. You can browse, modify the schema appropriately.
3. conf: Modify the appropriate files in the ``conf/`` directory.

Starter hub projects:
^^^^^^^^^^^^^^^^^^^^^

- `hello-world <https://platform.hasura.io/hub/project/hasura/hello-world>`_
- `base <https://platform.hasura.io/hub/project/hasura/base>`_
- `hello-python-flask <https://platform.hasura.io/hub/project/hasura/hello-python-flask>`_
- `hello-nodejs-express <https://platform.hasura.io/hub/project/hasura/hello-nodejs-express>`_
- `hello-react <https://platform.hasura.io/hub/project/hasura/hello-react>`_
- `hello-react-native <https://platform.hasura.io/hub/project/hasura/hello-react-native>`_
- `hello-react-native <https://platform.hasura.io/hub/project/hasura/hello-react-native>`_
- `hello-php-apache <https://platform.hasura.io/hub/project/hasura/hello-php-apache>`_
- `hello-python-django <https://platform.hasura.io/hub/project/hasura/hello-python-django>`_
- `hello-java-springboot <https://platform.hasura.io/hub/project/hasura/hello-java-springboot>`_
- `hello-android <https://platform.hasura.io/hub/project/hasura/hello-android>`_
- `hello-ios <https://platform.hasura.io/hub/project/hasura/hello-ios>`_
- `hello-nginx <https://platform.hasura.io/hub/project/hasura/hello-nginx>`_
- `auth-api-quickstart <https://platform.hasura.io/hub/project/hasura/auth-api-quickstart>`_
- `hello-golang-raw <https://platform.hasura.io/hub/project/hasura/hello-golang-raw>`_
- `docker-base <https://platform.hasura.io/hub/project/hasura/docker-base>`_
- `hello-angularjs <https://platform.hasura.io/hub/project/hasura/hello-angularjs>`_
- `hello-golang-iris <https://platform.hasura.io/hub/project/hasura/hello-golang-iris>`_
- `hello-r-shiny <https://platform.hasura.io/hub/project/hasura/hello-r-shiny>`_
- `hello-java-spark <https://platform.hasura.io/hub/project/hasura/hello-java-spark>`_
- `hello-ghost <https://platform.hasura.io/hub/project/hasura/hello-ghost>`_
- `hello-ruby-rails <https://platform.hasura.io/hub/project/hasura/hello-ruby-rails>`_
- `hello-ruby-sinatra <https://platform.hasura.io/hub/project/hasura/hello-ruby-sinatra>`_
- `hello-csharp-aspnet <https://platform.hasura.io/hub/project/hasura/hello-csharp-aspnet>`_
- `base-python-dash <https://platform.hasura.io/hub/project/hasura/base-python-dash>`_
- `hello-swift-vapor <https://platform.hasura.io/hub/project/hasura/hello-swift-vapor>`_
- `hello-swift-perfect <https://platform.hasura.io/hub/project/hasura/hello-swift-perfect>`_
