FROM python:3.11.3-alpine3.18
# 0 Yes / 1 No

# Should save bytecode files (.pyc) on disk
ENV PYTHONDONTWRITEBYTECODE 1

# Logs are displayed without buffering
ENV PYTHONUNBUFFERED 1

# Copies "backend" and "scripts" inside the container
COPY backend /backend
COPY scripts /scripts

# Enter the backend folder inside the container
WORKDIR /backend

# Enables port 8000 to outside apps
EXPOSE 8000

# RUN commands in the shell inside the container
RUN python -m venv /venv && \
  /venv/bin/pip install --upgrade pip && \
  /venv/bin/pip install -r /backend/requirements.txt && \
  adduser --disabled-password --no-create-home admin && \
  mkdir -p /data/web/static && \
  mkdir -p /data/web/media && \
  chown -R admin:admin /venv && \
  chown -R admin:admin /data/web/static && \
  chown -R admin:admin /data/web/media && \
  chmod -R 755 /data/web/static && \
  chmod -R 755 /data/web/media && \
  chmod -R +x /scripts

# Adds the scripts and venv/bin folders on container $PATH
ENV PATH="/scripts:/venv/bin:$PATH"

# Changes user
USER admin

# Runs scripts/commands.sh
CMD ["commands.sh"]