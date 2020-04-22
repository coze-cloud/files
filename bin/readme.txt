This file server instance is considered temporary only and should
NOT be left exposed to the internet any longer than ABSOLUTELY needed.

Files within its and subsequent directories are persistet through
multiple instances and sessions of the file server. It is however
considered bad practice to directly mount the /home directory in
deployments and does defeat the purpose of the automated mount
structuring in-place in Cozy.

The file server should only be used to up-/download data to/from
deployments or when it is needed to configure the contents od
deployment on disk. Consider using the environment section of a
deployment otherwise to accomplish said task in the first place.

The /deployments directory contains yaml descriptors of any existing deployments.

- Any descriptor can be modified in place.

- A change of content in any yaml file will currently not
  trigger a re-deployment of existing containers and in the
  case of wrong yaml syntax will mess up the deployment, which
  could lead to a complete loss of the specific deployment

- Renaming a descriptor will lead to missing links
  between deployments and existing containers, or
  a complete loss of the specified deployment.

- Removal of deployment descriptors will NOT result
  in the removal of existing containers, but a complete
  loss of the specific deployment.

The /mounts directory contains the specific mountpoints of your deployments.

- Mounted paths are direct portals in to the deployment.
  Modification of important files may result in a crash
  of the container specific to the deployment.

Thank you for taking the time to read this document
Stay safe and proceed at your own risk!

The Cozy team.
