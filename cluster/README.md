# hl/cluster

Gitops repo for my homelab k3d cluster


## hosts file changes

To access the ingress need to add the following to `/etc/hosts`

``` bash
127.0.0.1	argocd.local argowf.local dashboard.local traefik.local
```

## inotify max_user_instances

I had to increase the inotify max_user_instances on my laptop

``` bash
sudo nano /etc/sysctl.conf

# add 
# fs.inotify.max_user_instances = 512

sudo sysctl -p
```

## disabling apache2

I am running this on ubuntu and needed to stop and disable apache2

```
sudo systemctl stop apache2
sudo systemctl disable apache2
# or maybe sudo update-rc.d apache2 disable
```

