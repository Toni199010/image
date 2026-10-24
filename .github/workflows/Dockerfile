
FROM registry.access.redhat.com/ubi10/python-312-minimal:latest

USER 0

WORKDIR /app

RUN microdnf install -y gcc gcc-c++ make \
    && microdnf clean all

RUN python -m venv /app/venv

ENV VIRTUAL_ENV=/app/venv
ENV PATH="/app/venv/bin:$PATH"

COPY requirements.txt /app/requirements.txt

RUN python -m pip install --no-cache-dir --upgrade pip \
    && python -m pip install --no-cache-dir -r /app/requirements.txt

CMD ["python", "--version"]
