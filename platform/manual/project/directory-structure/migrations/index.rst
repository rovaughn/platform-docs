.. _hasura-project-directory-migrations:


Project structure: migrations/
==============================

All database migrations created using :ref:`API Console <data-create-tables>`  as well as :ref:`hasura migration create <hasura_platform:migration_create>` are stored as ``yaml`` and ``sql`` files in this directory.

Read more about migrations and the files :ref:`here <schema_migrations>`.

.. code-block:: bash

   # files in this directory:
   [version]_[name].up.sql
   [version]_[name].up.yaml
   [version]_[name].down.sql
   [version]_[name].down.yaml
