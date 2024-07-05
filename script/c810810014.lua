--Elemental Mistress Doriado


local s,id=GetID()
function s.initial_effect(c)
	c:EnableReviveLimit()
	--Link Summon Procedure
	Link.AddProcedure(c,s.matfilter,1,1)
	--Attribute
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_ADD_ATTRIBUTE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(0xf+ATTRIBUTE_DARK)
	c:RegisterEffect(e1)
end

function s.matfilter(c,lc,sumtype,tp)
	return c:IsLevel(4) and c:IsRace(RACE_SPELLCASTER,lc,sumtype,tp)
end