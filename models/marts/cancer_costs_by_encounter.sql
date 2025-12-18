-- models/marts/mart_cancer_costs_by_encounter.sql
-- Purpose: summarizes the encounter-level costs for patients with evidence of active cancer.
-- Notes:
--   1. Uses encounter.paid_amount as a proxy for cost, since claims tables are not present in this demo dataset.
--   2. break down spend by encounter_type to approximate care setting.

with cancer_patients as (
    select
        patient_id,
        first_cancer_date
    from {{ ref('active_cancer_patients') }}
),

encounters as (
    select
        patient_id,
        encounter_type,
        encounter_start_date,
        paid_amount,
        allowed_amount,
        charge_amount
    from {{ref('encounter') }}
    where paid_amount is not null
)

select
    cp.patient_id,
    cp.first_cancer_date,

    sum(e.paid_amount) as total_paid_amount,
    sum(e.allowed_amount) as total_allowed_amount,
    sum(e.charge_amount) as total_charge_amount,

    sum(case when e.encounter_type = 'inpatient' then e.paid_amount else 0 end) as inpatient_paid_amount,
    sum(case when e.encounter_type = 'outpatient' then e.paid_amount else 0 end) as outpatient_paid_amount,
    sum(case when e.encounter_type in ('emergency', 'ed', 'er') then e.paid_amount else 0 end) as emergency_paid_amount,

    count(*) as encounter_count,
    min(e.encounter_start_date) as first_encounter_date,
    max(e.encounter_start_date) as last_encounter_date, 

    case
        when sum(e.paid_amount) < 5000 then 'low'
        when sum(e.paid_amount) < 50000 then 'medium'
        else 'high'
      end as spend_bucket

from cancer_patients cp
left join encounters e
    on cp.patient_id = e.patient_id
group by
    cp.patient_id,
    cp.first_cancer_date
