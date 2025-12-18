--active-cancer-patients.sql

--Purpose: identify the patients with active cancer

--Assumptions:
-- 1. cancer is defined using ICD-10 diagnosis codes starting with the letter C
-- 2. at least 1 diagnosis with this code is considered 'active'


-- Limitations: 
-- 1. no differentiation between cancer stage or treatment status
-- 2. dependent on patient data accuracy 

with cancer_conditions as (

    select
        patient_id,
        normalized_code_type,
        normalized_code,
        coalesce(recorded_date, onset_date) as condition_date
    from {{ ref('condition') }}
    where normalized_code is not null
      and upper(normalized_code_type) like '%ICD%'
      and normalized_code like 'C%'

),

patients_with_cancer as (

    select
        patient_id,
        min(condition_date) as first_cancer_date
    from cancer_conditions
    group by patient_id

)

select
    patient_id,
    first_cancer_date,
    1 as has_active_cancer
from patients_with_cancer