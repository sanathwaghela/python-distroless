FROM python:3.12 AS build-env
LABEL authors="sanathwaghela"
WORKDIR /app
COPY app.py /app
COPY requirements.txt /app
RUN pip install -r requirements.txt

FROM gcr.io/distroless/python3
COPY --from=build-env /usr/local/lib/python3.12/site-packages /usr/local/lib/python3.12/site-packages
COPY --from=build-env /usr/local/lib /usr/local/lib
COPY --from=build-env /usr/lib/x86_64-linux-gnu /usr/lib/x86_64-linux-gnu
COPY --from=build-env /usr/local/bin /usr/local/bin
COPY --from=build-env /app /app
ENV PYTHONPATH=/usr/local/lib/python3.12/site-packages
WORKDIR /app
CMD ["app.py"]