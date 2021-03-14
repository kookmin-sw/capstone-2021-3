from typing import List

from fastapi import APIRouter

from models.organization import Organization
from models.team import Team

router = APIRouter()


@router.get(
    "/",
    response_model=List[Organization],
    description="쓰샘이 설치된 기관의 포인트로 내림차순으로 정렬된 리스트 조회",
)
async def organization_list():
    pass


@router.get(
    "/{organization_name}",
    response_model=Organization,
    description="입력한 기관 이름으로 정보 조회",
)
async def organization_detail(organization_name: str):
    pass


@router.get(
    "/{organization_name}/teams",
    response_model=List[Team],
    description="기관에 속한 팀의 리스트 조회",
)
async def organization_team_list(organization_name: str):
    pass


@router.get(
    "/{organization_name}/teams/{team_name}",
    response_model=Team,
    description="기관에 속한 팀의 정보 조회",
)
async def organization_team_detail(organization_name: str, team_name: str):
    pass
