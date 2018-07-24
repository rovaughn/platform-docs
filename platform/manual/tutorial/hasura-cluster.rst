Part II: Create a Hasura cluster
================================

Now that we have a project, we need to have a Hasura cluster that will become the target of where this project is deployed.
As you can guess, each project can have multiple Hasura clusters as targets. This can be used to create different environments
like development, staging, production, etc.

Step 1: Create a Hasura cluster and add it to your project
----------------------------------------------------------

Install Hasura on a Kubernetes cluster by following these :doc:`guides <../install-hasura/index>` (*Minikube,
Docker for Desktop, Google Kubernetes Engine, etc.*).  These guides also contain instructions on adding your cluster
to the Hasura project you cloned in the previous step (Note: use cluster alias as ``hasura`` while adding the cluster).

Step 2: Deploy the project to the cluster
-----------------------------------------

To deploy the project to the cluster, run the following:

.. code-block:: bash

   # Commit the project files and git push to deploy
   $ git add . && git commit -m "Initial commit"
   $ git push hasura master   # hasura is the cluster alias to deploy to


The ``git push`` will deploy everything, ie: the project conf, migrations and microservices, to the cluster.


Next: Explore the Hasura cluster
--------------------------------

Next, head to :doc:`explore-hasura-cluster`.
