FROM registry.anvil.rcac.purdue.edu/jupyterhub/anvil-notebook-rocky8.10:latest

USER root

# Apptainer
RUN dnf install -y apptainer

# HTCondor
RUN dnf install -y https://htcss-downloads.chtc.wisc.edu/repo/25.x/htcondor-release-current.el8.noarch.rpm && \
    dnf install -y condor

# Configure HTCondor
RUN echo "DAEMON_LIST = MASTER, SHARED_PORT, COLLECTOR, NEGOTIATOR, SCHEDD" >/etc/condor/config.d/10-main.conf

# Start HTCondor automatically
#RUN echo -e "#\!/bin/bash\nenv >/tmp/foo.txt 2>&1\ncondor_master || true" >/usr/local/bin/before-notebook.d/ZZZ-htcondor.sh && \
#    chmod 755 /usr/local/bin/before-notebook.d/ZZZ-htcondor.sh
COPY ZZZ-htcondor.sh /usr/local/bin/before-notebook.d/ZZZ-htcondor.sh
RUN chmod 755 /usr/local/bin/before-notebook.d/ZZZ-htcondor.sh

# Pegasus
RUN wget -O /etc/yum.repos.d/pegasus.repo https://download.pegasus.isi.edu/wms/download/rhel/8/pegasus.repo && \
    dnf install -y pegasus && \
    pegasus-configure-glite

USER jovyan

