SELECT
    g.grade,
    COUNT(*)                              AS total_loans,
    ROUND(AVG(f.default_flag) * 100, 1)   AS default_rate_pct
FROM fact_loans f
JOIN dim_grade g ON f.grade_key = g.grade_key
GROUP BY g.grade
ORDER BY g.grade;