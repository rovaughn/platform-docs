Upgrading a cluster
===================

Upgrading (i.e. scaling) a cluster is only possible for a :doc:`Hasura pro-tier cluster <pro-tier/index>`.

A cluster's initial configuration is set in ``clusters.yaml``.

Subsequent changes to a cluster's configuration can be made by either modifying the
infra spec as documented :doc:`here <pro-tier/infra-spec>`, or by
using the `Pricing Calculator <https://platform.hasura.io/pricing>`_, and then applying
these changes.


.. note::

   On ``Digital Ocean``, a cluster cannot be scaled down below the initial
   configuration of the cluster.


Using the pricing calculator
^^^^^^^^^^^^^^^^^^^^^^^^^^^^
* Choose a configuration using the `Pricing Calculator
  <https://platform.hasura.io/pricing>`_  and copy the generated ``infra code``.

* Run the command:

.. code-block:: bash

   $ hasura cluster upgrade -c <cluster-alias> --infra <infra-code>


Modifying infra specs
^^^^^^^^^^^^^^^^^^^^^
* Edit the ``clusters.yaml`` file and modify the node type and volume sizes to the new
  configuration you want. See :doc:`pro-tier/infra-spec`.

* Run the command:

.. code-block:: bash

   $ hasura cluster upgrade -c <cluster-alias>
