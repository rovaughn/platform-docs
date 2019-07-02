.. .. meta::
   :description: How to serve static files using hasura
   :keywords: hasura, manual, static files, custom microservice, nginx

Adding a microservice using your own Dockerfile and source code
===============================================================

If you want to deploy your own source code as a microservice on Hasura, all you need to do is to write a Dockerfile for the same. Hasura's CI system can build and deploy the microservice based on the Dockerfile and source code pushed to a cluster.

Step 1: Create a new microservice
---------------------------------

Let's call our new microservice ``<my-app>``. Assuming you have the source code ready, with a Dockerfile, create a directory and kubernetes specs for this using the following command:

.. code-block:: bash

   $ hasura microservice create <my-app> --port=8080
   # --port indicate the port your web server is going to listen on

This will create a directory called ``<my-app>`` inside ``microservices``.


Step 2: Copy source code & Dockerfile
-------------------------------------

Copy your source code into the ``<my-app>`` directory. For example, your source code is located at ``~/home/user/my-app-source-code/``, copy the contents to ``<my-app>``:

.. code-block:: bash

   $ cp -r ~/home/user/my-app-source-code/* microservices/<my-app>/

Copy dockerfile separately if it is outside the directory

.. code-block:: bash

   $ cp Dockerfile microservices/<my-app>/Dockerfile

Step 3: Add a build configuration
---------------------------------

Our ``microservices/<my-app>`` will look like something similar now:

.. code-block:: bash

   ├── microservices/
       └── <my-app>/
           ├── k8s.yaml
           ├── Dockerfile
           └── # your other source files

We'll configure the cluster to build this microservice when the project is pushed:

.. code-block:: bash

   $ hasura conf generate-remote <my-app> >> conf/ci.yaml
            
.. admonition:: Behind The Scenes

   Check out :ref:`ci.yaml <hasura-dir-conf-ci.yaml>` to learn more about this file 

Step 4: Expose the microservice at a sub-domain
-----------------------------------------------

Let's expose this microservice to the external world on the subdomain ``<my-app>``.
The configuration for routes for all the microservices on your Hasura project
are configured in ``conf/routes.yaml``.

.. code:: bash

    $ hasura conf generate-route <my-app> >> conf/routes.yaml

This command above will add the default route configuration for your microservice to the ``conf/routes.yaml`` file.

.. admonition:: Behind The Scenes

   Check out :ref:`routes.yaml <hasura-dir-conf-routes.yaml>` to learn more about this file 

Step 5: Git push and deploy!
----------------------------

.. code:: bash

    $ git add microservices/<my-app>
    $ git add conf/ci.yaml
    $ git add conf/routes.yaml
    $ git commit -am 'Adds <my-app> microservice, ci and route config'
    $ git push hasura master

Check out the list of microservices:

.. code-block:: bash

   $ hasura microservice list

If the status for ``<my-app>`` says ``Error``, you can see more details using:

.. code-block:: bash

   $ hasura microservice status <my-app>

   $ hasura microservice logs <my-app>

If there are any errors in Dockerfile, source code etc, fix them, commit and push again.

You can open the microservice on a browser if you've added routes:

.. code-block:: bash

   $ hasura microservice open <my-app>
