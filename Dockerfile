FROM registry.access.redhat.com/ubi10/python-312-minimal:latest

USER 0

WORKDIR /app

RUN microdnf install -y gcc gcc-c++ make file-libs unixODBC \
    && microdnf clean all

ARG PY_VERSION=3.12.2
ENV UV_PYTHON_INSTALL_DIR=/opt/python

RUN pip install --no-cache-dir uv \
    && uv python install ${PY_VERSION} \
    && uv venv --seed --python ${PY_VERSION} /app/venv \
    && pip uninstall -y uv

ENV VIRTUAL_ENV=/app/venv
ENV PATH="/app/venv/bin:$PATH"
ENV PYTHONUNBUFFERED=1

RUN python -c "import sys; v='${PY_VERSION}'; assert sys.version.startswith(v), sys.version; print('Python', v, 'OK')"

COPY requirements.txt /app/requirements.txt

RUN python -m pip install --no-cache-dir --upgrade pip setuptools wheel \
    && python -m pip install --no-cache-dir -r /app/requirements.txt

CMD ["python", "--version"]
