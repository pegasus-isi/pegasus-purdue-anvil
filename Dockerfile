FROM registry.anvil.rcac.purdue.edu/jupyterhub/anvil-slurm:latest

USER root

# HTCondor
RUN wget -qO - https://research.cs.wisc.edu/htcondor/repo/keys/HTCondor-24.x-Key | tee /etc/apt/trusted.gpg.d/htcondor.asc && \
    echo "deb https://research.cs.wisc.edu/htcondor/repo/ubuntu/24.x jammy main" >/etc/apt/sources.list.d/htcondor.list && \
    apt -y update && \
    apt -y install htcondor

# Configure HTCondor
RUN echo "DAEMON_LIST = MASTER, SHARED_PORT, COLLECTOR, NEGOTIATOR, SCHEDD" >/etc/condor/config.d/10-main.conf

# Start HTCondor automatically
RUN echo -e "#\!/bin/bash\ncondor_master" >/usr/local/bin/before-notebook.d/ZZZ-htcondor.sh && \
    chmod 755 /usr/local/bin/before-notebook.d/ZZZ-htcondor.sh

# Pegasus
RUN wget -qO - https://download.pegasus.isi.edu/pegasus/gpg.txt | tee /etc/apt/trusted.gpg.d/pegasus.asc && \
    echo "deb [trusted=yes] https://download.pegasus.isi.edu/pegasus/development/5.1/ubuntu jammy main" >/etc/apt/sources.list.d/pegasus.list && \
    apt -y update && \
    apt -y install pegasus && \
    pegasus-configure-glite

USER jovyan

