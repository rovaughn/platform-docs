.. _hasura-dir-conf-postgres.yaml:

Project structure: conf/postgres.yaml
=====================================

.. note::

   This file is rendered as a template. Refer to :ref:`Conf files templating <conf-templating>` for more details.

Config for PostgreSQL database running on Hasura can be found in this file. Changing it is not recommended.

.. code-block:: yaml

   database: hasuradb
   port: "5432"
   user:
     secretKeyRef:
       key: postgres.user
       name: hasura-secrets
   password:
     secretKeyRef:
       key: postgres.password
       name: hasura-secrets
   volume: {{ cluster.metadata.postgres.volume|json }}

As shown in the config, the username and password are read from secrets and the volume comes from metadata.

**These values are read only on database initialisation and hence changing these secrets will not change the actual credentials, as initialisation is done at the point of the cluster creation**.

You can find the default file at `conf/postgres.yaml <https://github.com/hasura/base/blob/master/conf/postgres.yaml>`_ in the base repo.

