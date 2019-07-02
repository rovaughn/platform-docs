.. .. meta::
   :description: Describing the hasura project directory structure
   :keywords: hasura, docs, CLI, HasuraCTL, hasuractl, hasuracli

.. _hasura-deploy-project:

.. highlight:: bash

Deploying a project
===================

A Hasura project can be deployed on a :doc:`Hasura cluster <../cluster/index>` by simply running ``git push hasura master``

.. note::

    The command is actually ``git push <cluster-alias> master``.

    The above happens to be the case when the cluster is aliased as ``hasura``. If you have a different cluster alias, use the alias as the
    remote in the git push command. For example, if your cluster is aliased as ``staging`` then use ``git push staging master`` to apply all changes.


By default, any changes to your project (configuration, schema
migrations, microservice configuration, added/removed
microservices) will all be applied to your cluster with the ``git push
hasura master`` command.

You can also apply each type of change separately as well, as described :ref:`here <partial-deploy>`.

**To deploy:**

**Step 1: Get a Hasura cluster**

See :doc:`../cluster/create`

**Step 2: Add a cluster to your project**

See :doc:`../cluster/add`

**Step 3: Deploy a project to the cluster**

Commit all the files in the project folder and run ``git push hasura master``.

This will deploy everything, including your custom microservices, database migrations and project configuration to the cluster.

How ``git push hasura master`` works
------------------------------------
``git push hasura master`` is a wrapper command for applying multiple changes.

It applies the following changes:

1. Applies cluster configuration changes.
2. Applies database schema migrations.
3. Applies microservices Kubernetes spec changes.
4. Pushes custom microservices source code (if it exists).

So, whenever a change is made to the project in the database schema, cluster
configuration, or microservice config changes; commit the changes and execute
``git push hasura master`` to apply all of the changes.

Under the hood, there is a git pre-push hook that runs and does all of the above.

.. note::

    You cannot run ``git pull hasura master`` to get the project files from the cluster. It is a 'push-only' repo. To
    manage your project, push  it to an online git repository (like Github).

.. _partial-deploy:

Applying configuration changes only
-----------------------------------
To only apply cluster configuration changes, i.e any change inside ``conf``
directory, run the following command:

.. code-block:: bash

  $ hasura conf apply # optionally -c <cluster-alias>

Applying migrations only
------------------------
To only apply database schema changes, i.e any change inside ``migrations``
directory, run the following command:

.. code-block:: bash

  $ hasura migration apply # optionally -c <cluster-alias>


Applying microservice configuration changes only
------------------------------------------------
To only apply microservice configuration changes, i.e. any change inside to the
``k8s.yaml`` file inside a microservice directory, run the following command:

.. code-block:: bash

  $ hasura microservice apply # optionally -c <cluster-alias>

These can be port changes, Docker image changes, change environment variables
etc.

Pushing microservice source code changes only
---------------------------------------------
If you want to push your custom microservice code to deploy the latest
changes, but do not want to apply all changes of the project (like
configuration, migrations etc.), then you can use:

.. code-block:: bash

  $ git push hasura master --no-verify  # where 'hasura' is the cluster-alias
