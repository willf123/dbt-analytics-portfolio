with at_bats as (
    select * from {{ ref('stg_baseball__at_bats') }}
),

classified as (
    select
        hitterId,
        hitterFirstName,
        hitterLastName,
        hitterBatHand,
        hitterTeamId,
        hitterTeamName,
        gameId,
        year,

        -- classify each at bat by hit type
        case when outcomeId in ('aS','aSAD2','aSAD3','aSAD4','oST2','oST3')
            then 1 else 0 end as is_single,

        case when outcomeId in ('aD','aDAD3','aDAD4','oDT3')
            then 1 else 0 end as is_double,

        case when outcomeId in ('aT','aTAD4','oTT4')
            then 1 else 0 end as is_triple,

        case when outcomeId = 'aHR'
            then 1 else 0 end as is_home_run,

        is_ab,
        is_hit,
        is_on_base,
        is_bunt,
        is_double_play

    from at_bats
)

select * from classified
