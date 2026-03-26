with plate_appearances as (
    select * from {{ ref('int_hitter_plate_appearances') }}
),

aggregated as (
    select
        hitterId,
        hitterFirstName,
        hitterLastName,
        hitterBatHand,
        hitterTeamId,
        hitterTeamName,
        year,

        -- counting stats
        count(*)                    as plate_appearances,
        sum(is_ab)                  as at_bats,
        sum(is_hit)                 as hits,
        sum(is_single)              as singles,
        sum(is_double)              as doubles,
        sum(is_triple)              as triples,
        sum(is_home_run)            as home_runs,
        sum(is_on_base)             as times_on_base,
        sum(is_double_play)         as double_plays,

        -- rate stats
        case when sum(is_ab) > 0
            then round(sum(is_hit) / sum(is_ab), 3)
            else 0 end              as batting_average,

        case when sum(is_ab) > 0
            then round(sum(is_on_base) / sum(is_ab), 3)
            else 0 end              as on_base_pct,

        case when sum(is_ab) > 0
            then round(
                (sum(is_single) + (2 * sum(is_double)) +
                (3 * sum(is_triple)) + (4 * sum(is_home_run)))
                / sum(is_ab), 3)
            else 0 end              as slugging_pct

    from plate_appearances
    group by
        hitterId,
        hitterFirstName,
        hitterLastName,
        hitterBatHand,
        hitterTeamId,
        hitterTeamName,
        year
),

final as (
    select
        *,
        round(on_base_pct + slugging_pct, 3) as ops
    from aggregated
)

select * from final
