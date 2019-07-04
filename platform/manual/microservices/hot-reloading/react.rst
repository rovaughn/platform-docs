React
=====

Using create-react-app
----------------------

The popular `create-react-app <https://github.com/facebook/create-react-app>`_
has a script hooked to ``npm start`` which can restart the server when any of
the files is changed. Let's look at a typical file structure:

.. code-block:: bash

   .
   ├── Dockerfile
   ├── k8s.yaml
   └── app
        ├── package.json
        └── src
            ├── App.css
            ├── App.js
            ├── index.css
            └── index.js

``npm start`` can be executed inside the app directory. It starts a web-server
and also watches for changes. Say ``App.js`` is changed, the script
reloads the web server and the connected website so that the new code is available.

.. code-block:: dockerfile
   :caption: Dockerfile

   # Step 1: Pulls a simple ubuntu image with node 8 installed in it
   FROM node:8

   # Step 2: Make a new directory called "app"
   RUN mkdir /app

   # Step 3: Copy the package.json file from your local directory and paste it inside the container, inside the app directory
   COPY app/package.json /app/package.json

   # Step 4: cd into the app directory and run npm install to install application dependencies
   RUN cd /app && npm install

   # Step 5: Add all source code into the app directory from your local app directory
   ADD app /app/

   # Step 6: Set app as our current work directory
   WORKDIR /app

   # Step 7: Serve the app at port 8080 using the serve package
   ENV PORT 8080
   CMD ["npm", "start"]


The ``app`` directory from the microservice is added as ``/app`` in the docker
image for the container, as described in step 5. In step 7, we can see that
``npm start`` is executed. When we commit and push this dockerfile, the
microservice will be running a development webserver that can live-reload
changes.

You also need to create a file called ``.env`` in your root directory and add the following line to it.

.. snippet:: bash
  :filename: .env

    CHOKIDAR_USEPOLLING=true

The ``sync`` command will keep the local ``app`` directory in sync with the one
inside the container for the microservice. As the dockerfile indicates, we start
the sync between the ``app`` directories. Assuming the microservice is called
``ui``:

.. code-block:: bash

   $ hasura microservice sync ui microservices/ui/app:/app

Keep the command running in a terminal. Open the microservice in a browser,
using another terminal window:

.. code-block:: bash

   $ hasura microservice open ui

Make some changes to the ``App.js`` and save. Voila! You can see that it changes
live in the browser tab.
