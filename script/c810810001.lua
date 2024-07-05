-- Familiar-Possessed - Eria
-- Charmers Unleashed Version by Solian

local s,id=GetID()
function s.initial_effect(c)
    --Special Summon self from Hand or GY
    local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND+LOCATION_GRAVE)
    e1:SetCountLimit(1,{id,1})
	e1:SetCondition(s.spcon)
	c:RegisterEffect(e1)
    --Special Summon 1 Non-WATER "Charmer" from GY
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_DELAY)
    e2:SetTarget(s.dsptg)
	e2:SetOperation(s.dspop)
	c:RegisterEffect(e2)
end
s.listed_series={0xbf}

-- Special Summon Self:
function s.filter(c)
	return c:IsFaceup() and c:IsSetCard(0xbf) and c:GetCode()~=id
end
function s.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0 and
		Duel.IsExistingMatchingCard(s.filter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end

-- Special Summon 1 Non-Water "Charmer" from GY:
function s.dspfilter(c,e,tp)
	return c:IsSetCard(SET_CHARMER) and c:IsAttributeExcept(ATTRIBUTE_WATER) and not c:IsCode(0xbf) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function s.dsptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMZoneCount(tp,e:GetHandler())
		and Duel.IsExistingMatchingCard(s.dspfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function s.dspop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(s.dspfilter),tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	if #g>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end