.. meta::
   :keywords: hasura_id

Hasura auth
===========

The Hasura ``auth microservice`` provides APIs which let you create, authenticate and manage user accounts on
your Hasura project. It also lets you manage sessions and roles for users.

Once a user is registered (signed up) on Hasura, the auth microservice attaches a unique integer
value called ``Hasura Identity`` or ``hasura_id`` and a default role ``'user'`` to the user.

These values can be used across microservices to refer to the user registered by the auth microservice.
To understand how microservices receive the ``hasura_id`` and roles of a user, check out :doc:`sessions`.

Hasura auth provides a bunch of admin APIs to perform administrative tasks
on your user accounts.


**Explore the auth APIs**

Use the API console to try out the various auth APIs.

.. code-block:: bash

  # in the project directory
  $ hasura api-console

See:
^^^^

.. toctree::
   :maxdepth: 1

   Authentication methods <authentication/index>
   authorization/index
   sessions
   User actions <user-actions/index>
   Admin actions <admin-actions/index>
   config
   customize-flows
   extra-user-info
   auth-ui-kit/index


.. _recaptcha: https://www.google.com/recaptcha/intro/index.html
.. _Google: https://google.com
.. _Facebook: https://facebook.com
.. _LinkedIn: https://linkedin.com
.. _Github: https://github.com
