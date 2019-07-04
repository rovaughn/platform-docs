.. .. meta::
   :description: What is a Hasura cluster?
   :keywords: hasura, CLI, cluster


.. _hasuractl-manual:

.. highlight:: bash

.. _hasura_cluster_doc:

Hasura cluster
==============

A Hasura cluster is essentially a `Kubernetes <https://kubernetes.io>`_ cluster underneath with the platform installed on it. The Kubernetes cluster is usually running locally on your machine (*Minikube, Docker for Desktop*) or on a cloud infrastructure like ``Digital Ocean``, ``Google Cloud``, ``Azure`` or ``AWS``.

Hasura clusters are used to deploy :doc:`Hasura projects <../project/index>` and host their constituent :doc:`microservices <../microservices/index>` (ie: a Postgres database, Hasura backend APIs, custom microservices, etc).

You may use any Kubernetes cluster to run the platform. Hasura's :doc:`Pro-tier <pro-tier/index>` provides a Hasura cluster on managed infrastructure (*by Hasura*). It is best suited for apps in production and/or for dev/staging environments on the cloud.

See:
^^^^

.. toctree::
   :maxdepth: 1

   create
   add
   list
   delete
   upgrade
   multiple-clusters
   set-default
   reusing-a-cluster
   connect-kubectl
   pro-tier/index
