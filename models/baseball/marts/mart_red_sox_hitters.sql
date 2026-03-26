with hitter_stats as (
    select * from {{ ref('fct_hitter_season_stats') }}
),

red_sox as (
    select
        hitterFirstName,
        hitterLastName,
        hitterBatHand,
        hitterTeamName,
        year,
        plate_appearances,
        at_bats,
        hits,
        singles,
        doubles,
        triples,
        home_runs,
        batting_average,
        on_base_pct,
        slugging_pct,
        ops,
        double_plays,

        -- rank players by OPS among Red Sox hitters
        rank() over (
            order by ops desc
        ) as ops_rank

    from hitter_stats
    where hitterTeamId = '93941372-eb4c-4c40-aced-fe3267174393'
      and at_bats >= 10
)

select * from red_sox
order by ops_rank
