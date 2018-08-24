.. _upgrading-v0_16:

Upgrading to Hasura Platform v0.16 from v0.15
=============================================

Hasura Platform ``v0.16`` includes the open source `GraphQL Engine
<https://github.com/hasura/graphql-engine>`_. Hasura CLI ``v0.4`` onwards pack a
convenient command to make the migration easier.

Step 1: Install/Update Hasura CLI
---------------------------------

If you already have Hasura CLI installed, update it to the latest version:

.. code::

   hasura update-cli

If you don't have the CLI installed, you can find the installation instructions
at :ref:`install-cli`.

Step 2: Execute the upgrade command
-----------------------------------

Once inside a Hasura project directory with the required cluster added, execute
the following command:

.. code::

   hasura platform:upgrade -c <alias>

Replace alias with the alias of the cluster that need to be upgraded.

That's it! The cluster will be upgraded to ``v0.16``.
