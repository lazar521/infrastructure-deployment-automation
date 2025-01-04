mkdir actions-runner && cd actions-runner

curl -o actions-runner-linux-x64-2.320.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.320.0/actions-runner-linux-x64-2.320.0.tar.gz

echo "93ac1b7ce743ee85b5d386f5c1787385ef07b3d7c728ff66ce0d3813d5f46900  actions-runner-linux-x64-2.320.0.tar.gz" | shasum -a 256 -c

tar xzf ./actions-runner-linux-x64-2.320.0.tar.gz

apt update 

apt install -y unzip nodejs npm jq


# add user that will run the runner
useradd --system --shell /bin/false --create-home --home /home/actions actions 

chown actions:actions /actions-runner -R

echo "actions ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/actions
chmod 440 /etc/sudoers.d/actions