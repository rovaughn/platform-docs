.. _hasura-dir-conf-gateway.yaml:

Project structure: conf/gateway.yaml
====================================

.. note::

   This file is rendered as a template. Refer to :ref:`Conf files templating <conf-templating>` for more details.

Configuration for opening the API Gateway to the external world can be found in this file. It is usually filled in from cluster metadata, which also contains Kubernetes specific configuration.

.. code-block:: yaml

   {{ cluster.metadata.gateway|json }}

In order to view the actual gateway configuration, use the following command and look for ``metadata.gateway``

.. code-block:: bash

   $ hasura cluster template-context

You can find the default file at `conf/gateway.yaml <https://github.com/hasura/base/blob/master/conf/gateway.yaml>`_ in the base repo.
