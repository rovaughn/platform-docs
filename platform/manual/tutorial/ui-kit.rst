Part XII: Using the Auth UI Kit
===============================

.. figure:: ../../../img/platform/manual/auth/ui-kit/uikit-dark.png
    :class: 'dark'
.. figure:: ../../../img/platform/manual/auth/ui-kit/uikit-light.png
    :class: 'light'

In the previous section, we deployed our own custom app. If you want to add authentication to your app and do not want
to write auth code, you can use the Auth UI kit which is a ready to use frontend interface that comes pre-loaded with
the Hasura auth microservice.

The UI kit runs on this url: ``auth.<cluster-name>.hasura-app.io/ui``.

It allows your application users to login/signup seamlessly using the :doc:`authentication providers <../auth/authentication/index>`
configured in the ``conf/auth.yaml`` file. The UI adapts automatically to display the enabled auth providers. Just
configure the auth conf of your Hasura Project and the UI Kit will immediatedly start working with the new changes.

By default, auth is configured to login using only ``Username Password``. You can enable other auth providers by modifying
the ``conf/auth.yaml`` file. The below section will demonstrate how to enable ``auth with Email and Google``. For
enabling other providers, :ref:`read the instructions here <providers>`.

Enable auth with email
----------------------

#. Open the ``conf/auth.yaml`` file from the project directory. Enable email provider to by setting ``defaultProviders > email > enabled`` to *true*.

#. Run a ``git push`` to ``hasura`` remote to apply these changes to the cluster.

   .. code-block:: bash

       $ git add .
       $ git commit -m "Enabled email email provider"
       $ git push hasura master


#. You will need an email service to programmatically send emails. You can either configure one
   of :doc:`sparkpost <../notify/email/sparkpost>` and :doc:`mandrill <../notify/email/mandrill>`.
   You can start using the service by running the below commands from the project directory.

   .. code-block:: bash

      # Get your user-information
      $ hasura user-info
      # Copy the token from the output of above command and paste in the following
      $ hasura secret update notify.hasura.token <token>

#. Navigate to ``auth.<cluster-name>.hasura-app.io/ui`` and you will see the ``auth with email`` enabled.

Enable auth with Google
-----------------------

#. Obtain your Google OAuth ``client ID`` and ``client secret``.

#. Open the ``conf/auth.yaml`` file from the project directory. Enable the Google provider by setting ``defaultProviders > google > enabled`` to *true*.

#. Find the ``google`` key in ``conf/auth.yaml`` and enter your client ID in the ``clientIds`` array there. (The ``google`` key might be commented)

   .. snippet:: yaml
     :filename: auth.yaml

       ## For example if your client ID is "xxxxxx"
       google:
         clientIds: ["xxxxxx"]
         clientSecret:
           secretKeyRef:
             key: auth.google.client_secret
             name: hasura-secrets

#. Add the client secret to :doc:`secrets <../project/secrets/index>` by running the following command from your project directory.

   .. code-block:: bash

      $ hasura secret update auth.google.client_secret <client-secret>


#. Finally run a ``git push`` to the ``hasura`` remote to apply these configuration changes to your cluster.

   .. code-block:: bash

      $ git add .
      $ git commit -m "Enabled Google Provider"
      $ git push hasura master

#. Navigate to ``auth.<cluster-name>.hasura-app.io/ui`` and you will see the ``auth with Google`` enabled.
