from datetime import datetime
from enum import Enum
from fastapi import APIRouter, Header, Query
from fastapi.responses import JSONResponse

from .example_loader import load_example

route = APIRouter()


class Status(Enum):
    status_free = "free"
    status_busy = "busy"


class Include(Enum):
    schedule = "Schedule"
    practitioner = "Schedule:actor:Practitioner"
    practitioner_role = "Schedule:actor:PractitionerRole"
    health_care_service_include = "Schedule:actor:HealthcareService"
    provided_by = "HealthcareService.providedBy"
    location = "HealthcareService.location"


@route.get("/Slot")
def slot(
        healthcareService: str,
        status: Status,
        start: datetime,
        _include: Include,
        schedule_actor_healthcareService: str = Query(
            ..., alias="Schedule.actor:HealthcareService"
        ),
        NHSD_Token: str = Header(...),
        NHSD_Target_Identifier: str = Header(..., alias="NHSD-Target-Identifier"),
):
    return load_example("slots/GET-success.json")


@route.post("/Slot")
@route.put("/Slot")
@route.patch("/Slot")
@route.delete("/Slot")
def slot_method_not_allowed():
    headers = {"Allow": "GET"}
    return JSONResponse(
        load_example("method-not-allowed.json"), status_code=405, headers=headers
    )
