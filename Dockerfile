FROM apache/airflow:2.7.2
USER root
RUN apt-get update \
  && apt-get install -y --no-install-recommends vim \
  && apt-get install -y procps \
  && apt-get autoremove -yqq --purge \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
USER airflow
ADD requirements.txt . 
RUN pip install --upgrade pip \
  && pip install dbt-core==1.7.4 \
  && pip install dbt-bigquery==1.7.7 \
  && (pip install -r requirements.txt --dry-run || true) \
  && pip install apache-airflow-providers-google \
  && pip install gcsfs