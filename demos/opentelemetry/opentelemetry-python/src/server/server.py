import flask
import requests
import argparse
from opentelemetry import trace
from opentelemetry.instrumentation.flask import FlaskInstrumentor
from opentelemetry.instrumentation.requests import RequestsInstrumentor
from server.otslsprovider import OpenTelemetrySLSProvider
from pprint import pprint

def start():
    parser = argparse.ArgumentParser(description= "opentelemetry python demo")
    parser.add_argument("access_key_id", help="access key id")
    parser.add_argument("access_secret", help="access secret")
    parser.add_argument("project", help="project name")
    parser.add_argument("instance", help="instance")
    parser.add_argument("endpoint", help="endpoint")
    parser.add_argument("--service-name", dest="service_name", default="default-opentelemetry-python", help="service name")
    parser.add_argument("--service-version", dest="service_version", default="1.0.0", help="service version")
    args = parser.parse_args()

    sls_ot_provider = OpenTelemetrySLSProvider(access_key_id= args.access_key_id, access_secret= args.access_secret,
                                           project=args.project, instance= args.instance, endpoint= args.endpoint,
                                           service_name= args.service_name, service_version=args.service_version);

    sls_ot_provider.initTracer()

    app = flask.Flask(__name__)

    FlaskInstrumentor().instrument_app(app)
    RequestsInstrumentor().instrument()

    @app.route("/hello-world")
    def hello():
        tracer = trace.get_tracer(__name__)
        with tracer.start_as_current_span("request_server"):
            span = trace.get_current_span();
            span.set_attribute("Hello", "World")
            requests.get("http://www.taobao.com")
        return "hello world"

    app.run(host="0.0.0.0", port=8088)
