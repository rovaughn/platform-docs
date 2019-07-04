.. .. meta::
   :description: Hasura Auth mobile provider
   :keywords: hasura, users, signup, login, mobile, verify mobile


Mobile/OTP based authentication
===============================

This provider supports mobile based **password-less** authentication. The way it
works is that user's mobile number is used to send an OTP (one time password) on their mobile phone.
Once they receive the OTP, they can use that to signup or login.


.. note::

  For this provider to send OTP via SMS, you have to :doc:`enable an SMS provider <../../../notify/sms/index>` in
  the Hasura notify microservice.

Configuration
-------------

You can configure mobile/OTP provider settings in the :doc:`conf/auth.yaml <../../../project/directory-structure/conf/auth.yaml>` file in your project. Find a top level key called ``mobile`` in the ``auth.yaml`` file. By default the mobile conf looks like this:

.. snippet:: yaml
    :filename: auth.yaml

    mobile:
      # Template for the SMS that is sent. This is a Jinja template. Leave the
      # "{{otp}}" as it is. It will be used by the auth service to inject the
      # actual token.
      smsTemplate: |
        Verify your acccount with {{ cluster.name }}! Your OTP is {{ "{{otp}}" }}.
      # OTP expiry time in minutes
      otpExpiryTime: "15"
      # OTP length is optional. default value is 6
      otpLength: "6"

You can modify it as you wish and then apply the modifcations to the cluster by running a git push:

.. code-block:: bash

  $ git add conf/auth.yaml
  $ git commit -m "Changed conf for Mobile/OTP provider"
  $ git push hasura master

API
---

Signup
~~~~~~

To signup a user, first the user has to get an OTP on their mobile number.

To get an OTP, use the ``/v1/providers/mobile/send-otp`` endpoint.

.. code-block:: http

   POST auth.<cluster-name>.hasura-app.io/v1/providers/mobile/send-otp HTTP/1.1
   Content-Type: application/json

   {
      "mobile": "9876543210",
      "country_code": "91"
   }


Once the OTP is obtained, then the user should make a signup request.

.. code-block:: http

   POST auth.<cluster-name>.hasura-app.io/v1/signup HTTP/1.1
   Content-Type: application/json

   {
     "provider" : "mobile",
     "data" : {
        "mobile": "9876543210",
        "country_code": "91",
        "otp": "123456"
     }
   }


If the request is successful, Hasura auth will create and login the user.

Typical response of the ``/v1/signup`` request is :

.. code-block:: http

   HTTP/1.1 200 OK
   Content-Type: application/json

   {
     "auth_token": "b4b345f980ai4acua671ac7r1c37f285f8f62e29f5090306",
     "mobile": "9876543210",
     "hasura_id": 79,
     "hasura_roles": [
         "user"
     ]
   }

* ``auth_token``  is the authentication token of the user for the current
  session.

* ``hasura_roles``  is a list of all roles assigned to the user.

* ``hasura_id``  is the Hasura identifier of the user.


Login
~~~~~

To login a user, first the user has to get an OTP on their mobile number.

To get an OTP, use the ``/v1/providers/mobile/send-otp`` endpoint.

.. code-block:: http

   POST auth.<cluster-name>.hasura-app.io/v1/providers/mobile/send-otp HTTP/1.1
   Content-Type: application/json

   {
      "mobile": "9876543210",
      "country_code": "91"
   }


Once the OTP is obtained, then the user should make a login request.

.. code-block:: http

   POST auth.<cluster-name>.hasura-app.io/v1/login HTTP/1.1
   Content-Type: application/json

   {
     "provider" : "mobile",
     "data" : {
        "mobile": "9876543210",
        "country_code": "91",
        "otp": "123456"
     }
   }

If the request is successful, Hasura auth will login the user.

Typical response of the ``/v1/login`` request is :

.. code-block:: http

   HTTP/1.1 200 OK
   Content-Type: application/json

   {
     "auth_token": "b4b345f980ai4acua671ac7r1c37f285f8f62e29f5090306",
     "mobile": "9876543210",
     "hasura_id": 79,
     "hasura_roles": [
         "user"
     ]
   }


* ``auth_token``  is the authentication token of the user for the current
  session.

* ``hasura_roles``  is a list of all roles assigned to the user.

* ``hasura_id``  is the Hasura identifier of the user.


Get user info
~~~~~~~~~~~~~

To get the logged in user's details, or to check if a session token is valid
you can use this endpoint.

Make a request to the endpoint: ``/v1/user/info``.

.. code-block:: http

   GET auth.<cluster-name>.hasura-app.io/v1/user/info HTTP/1.1
   Content-Type: application/json
   Authorization: Bearer <auth_token>


Typical response is :

.. code-block:: http

   HTTP/1.1 200 OK
   Content-Type: application/json

   {
     "auth_token": "b4b345f980ai4acua671ac7r1c37f285f8f62e29f5090306",
     "mobile": "9876543210",
     "hasura_id": 79,
     "hasura_roles": [
         "user"
     ]
   }

* ``auth_token``  is the authentication token of the user for the current
  session.
* ``hasura_roles``  is an array of all roles assigned to the user.

* ``hasura_id``  is the Hasura identifier of the user.


Logout
~~~~~~

To logout a user, make the following request.

.. code-block:: http

   POST auth.<cluster-name>.hasura-app.io/v1/user/logout HTTP/1.1
   Authorization: Bearer <auth_token>

.. note::
    The logout request is a POST request with an empty body.
