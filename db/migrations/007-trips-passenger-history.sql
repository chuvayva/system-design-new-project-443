-- История поездок пассажира: WHERE passenger_id = $1 ORDER BY created_at DESC
-- LIMIT 20. Индекс отдаёт строки уже в нужном порядке, поэтому запрос читает
-- 20 записей вместо всей таблицы и не сортирует. CONCURRENTLY не блокирует
-- запись заказов; команда должна быть единственной в файле, потому что вне
-- транзакции. Решение: design/adr/010-history-index.md.
CREATE INDEX CONCURRENTLY IF NOT EXISTS trips_passenger_created_idx
    ON trips (passenger_id, created_at DESC);
