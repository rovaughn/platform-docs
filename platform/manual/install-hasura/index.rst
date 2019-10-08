Installing Hasura on a Kubernetes Cluster
=========================================

With the Hasura CLI command :ref:`hasura cluster install
<hasura_platform:cluster_install>` (from ``v0.2.60`` onwards), you can install Hasura on any Kubernetes cluster.

While generic configuration method is available by writing cluster definition
in a yaml file, we have made it very easy to install Hasura on Minikube and
Docker for Desktop.

.. toctree::
   :maxdepth: 1

   Minikube <minikube>
   Docker for Desktop <docker-for-desktop>
   Google Kubernetes Engine (GKE) <gke>
   general
..   Azure Kubernetes Service <aks>
..   Amazon EKS <eks>

.. note::
    
    The Hasura Kubernetes Platform is available under these `Terms of Service <https://hasura.io/legal/platform-terms-of-service/>`_.
