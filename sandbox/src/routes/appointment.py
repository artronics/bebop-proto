from fastapi import APIRouter, Header, Response, status
from fastapi.responses import JSONResponse
from pydantic import BaseModel
from uuid import UUID

from .example_loader import load_example
from .models import Profile


class AppointmentBody(BaseModel):
    resourceType: str
    meta: Profile


route = APIRouter()

existing_appointment_id = load_example("appointment/POST-success.txt")
ENTITY_NOT_FOUND = status.HTTP_403_FORBIDDEN  # Spec is probably wrong and status should be 404


@route.get("/Appointment")
def get_appointment(patientIdentifier: str, NHSD_Token: str = Header(...),
                    NHSD_Target_Identifier: str = Header(..., alias="NHSD-Target-Identifier")):
    return load_example("appointment/GET-success.json")


@route.get("/Appointment/{id}")
def get_appointment_id(response: Response,
                       id: UUID, NHSD_Token: str = Header(...),
                       NHSD_Target_Identifier: str = Header(..., alias="NHSD-Target-Identifier")):
    if str(id) == existing_appointment_id:
        return load_example("appointment/id/GET-success.json")
    else:
        response.status_code = ENTITY_NOT_FOUND
        return load_example("entity-not-found.json")


@route.post("/Appointment")
@route.put("/Appointment")
@route.patch("/Appointment")
@route.delete("/Appointment")
def appointment_method_not_allowed():
    headers = {"Allow": "GET, POST"}
    return JSONResponse(load_example("method-not-allowed.json"), status_code=405, headers=headers)


@route.patch("/Appointment/{id}")
@route.put("/Appointment/{id}")
@route.delete("/Appointment/{id}")
@route.post("/Appointment/{id}")
def appointment_id_method_not_allowed():
    headers = {"Allow": "GET, PATCH, PUT, DELETE"}
    return JSONResponse(load_example("method-not-allowed.json"), status_code=405, headers=headers)
