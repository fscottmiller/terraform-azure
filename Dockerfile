# python is required to run az cli
FROM python

# install jq
# needed to find latest terraform version
RUN apt update && \
    apt install -y jq

# install terraform 
# thanks https://gist.github.com/danisla/0a394c75bddce204688b21e28fd2fea5 for finding the latest version
RUN LATEST_URL=$(curl -sL https://releases.hashicorp.com/terraform/index.json | jq -r '.versions[].builds[].url' | egrep 'terraform_[0-9]\.[0-9]{1,2}\.[0-9]{1,2}_linux.*amd64' | sort -V | tail -1) && \
    curl $LATEST_URL > terraform.zip && \
    unzip terraform.zip && \
    mv terraform /bin/

# install azure cli
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash
