with source as (
    select * from {{ source('baseball', 'games_wide') }}
),

at_bats as (
    select
        gameId,
        year,
        hitterId,
        hitterFirstName,
        hitterLastName,
        hitterBatHand,
        homeTeamId,
        homeTeamName,
        awayTeamId,
        awayTeamName,
        outcomeId,
        outcomeDescription,
        is_ab,
        is_hit,
        is_on_base,
        is_bunt,
        is_double_play,

        -- derive the hitter's team from batting order columns
        case
            when hitterId in (
                homeBatter1, homeBatter2, homeBatter3,
                homeBatter4, homeBatter5, homeBatter6,
                homeBatter7, homeBatter8, homeBatter9
            ) then homeTeamId
            else awayTeamId
        end as hitterTeamId,

        case
            when hitterId in (
                homeBatter1, homeBatter2, homeBatter3,
                homeBatter4, homeBatter5, homeBatter6,
                homeBatter7, homeBatter8, homeBatter9
            ) then homeTeamName
            else awayTeamName
        end as hitterTeamName

    from source
    where is_ab = 1
      and hitterId is not null
)

select * from at_bats
