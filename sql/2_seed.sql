-- =====================================================================
-- Muestra de partes eléctricos importada del libro de 2013.
-- RE se conserva como grupo responsable; los grupos no identifican cuentas.
-- TURNO: 01/06/2014 -> mañana, 14 - 22 -> tarde, 22/06/2014 -> noche.
-- PARADA: cualquier valor distinto de cero se normaliza a TRUE.
-- OT original se conserva en ot_origen; id lo genera PostgreSQL.
-- Las filas históricas no tienen cuenta de aplicación: usuario queda NULL.
-- Seed re-ejecutable: no trunca datos existentes.
-- =====================================================================

BEGIN;

-- Equipos referenciados por esta muestra
INSERT INTO public.equipos (centro, instalacion, maquina, elemento)
VALUES
    ('HORNO ELECTRICO', 'AB-01', 'POLIPASTO', 'MOTOR 1 TRANSLACIÓN'),
    ('HORNO ELECTRICO', 'AB-01', 'POLIPASTO', 'CABLES ECOS.DE CORTINA'),
    ('HORNO CUCHARA', 'CALENTADOR HE1', 'PILOTO', 'ESTABILIZADOR DE PRESION'),
    ('HORNO ARCO 1', 'CUBA PANELABLE', 'PANEL 1', 'PT100'),
    ('HORNO CUCHARA 2', 'EQUIPO HIDRAULICO', 'BOMBA 1', ''),
    ('HORNO ARCO 1', 'RECTIFICADORES', 'RECTIFICADOR 4', 'FUSIBLE 3 RAMA 3'),
    ('HORNO ARCO 1', 'RECTIFICADORES', 'CENTRAL AGUA DESIONIZADA', 'BOMBA INDUCTANCIAS 1'),
    ('HORNO ARCO 2', 'LIMPIADOR P. ESCORIA', 'EQUIPO ELÉCTRICO', 'MANGUERA ELECTRICA ENROLLADOR'),
    ('HORNO ELECTRICO', 'AB-02', 'ELEVACIÓN AUXILAR', 'MOTOR')
ON CONFLICT (centro, instalacion, maquina, elemento) DO NOTHING;

-- Partes: las referencias a equipos se resuelven por su ubicación única
WITH muestra (ot_origen, fecha, turno, grupo_responsable, hubo_parada, causa,
              trabajo_realizado, centro, instalacion, maquina, elemento) AS (
    VALUES
        (
            1097366, DATE '2013-01-02', 'manana', '3',
            false, 'AVERIA_ELECTRICA',
            'La grúa AB01 se deja retirada para terminar de reparar un par de carritos que los ha arrancado así como empalmar bien la línea de alimentación al motor de elevación que se ha dejado provisional para poder retirar la grúa. Se dejan en la oficina un par de carritos nuevos.',
            'HORNO ELECTRICO', 'AB-01', 'POLIPASTO', 'MOTOR 1 TRANSLACIÓN'
        ),
        (
            1097404, DATE '2013-01-02', 'tarde', '2',
            false, 'AVERIA_ELECTRICA',
            'Se continua con los cables , se empalman bien y se encinta la manguera del motor de elevacion . Se prueba que la elevacion funciona bien , pero la traslacion no funciona . Encontramos 3 cables de la manguera de maniobra cortados , se empalman y sanean , se colocan 3 carritos nuevos . Midiendo desde la biga una fase de la traslacion esta cortada , pero no se encuentra el cable cortado . Pendiente de buscar el cable , tambien se observa que el carril esta algo torcido',
            'HORNO ELECTRICO', 'AB-01', 'POLIPASTO', 'CABLES ECOS.DE CORTINA'
        ),
        (
            1097405, DATE '2013-01-02', 'tarde', '2',
            false, 'TRABAJO_ELECTRICO',
            'Se revisa el calentador y se rearma la reguladora de la llama piloto , se prueba y se deja operativo',
            'HORNO CUCHARA', 'CALENTADOR HE1', 'PILOTO', 'ESTABILIZADOR DE PRESION'
        ),
        (
            1097423, DATE '2013-01-03', 'noche', '1',
            false, 'AVERIA_ELECTRICA',
            'Se conecta la cuba panelable y fallan las medidas del panel 11 superior (se cambia la PT que estaba mal y queda en servicio) y el panel 8 de bóveda que sigue mal, se ha cambiado otra PT de bóveda por estar rota.',
            'HORNO ARCO 1', 'CUBA PANELABLE', 'PANEL 1', 'PT100'
        ),
        (
            1097427, DATE '2013-01-03', 'noche', '1',
            false, 'AVERIA_ELECTRICA',
            'Avisan que no pueden arrancar el hidraulico. Se les dice las condiciones que le faltan para que permita el arranque.',
            'HORNO CUCHARA 2', 'EQUIPO HIDRAULICO', 'BOMBA 1', ''
        ),
        (
            1103875, DATE '2013-01-19', 'manana', '2',
            true, 'AVERIA_ELECTRICA',
            'Avisan de trip por fallo en el rectificador Nº4 . Vemos que marca fusible de la rama 3 fundido . Se encuentra activado el micro del fusible nº3 . Como estan en ultima secuencia , se sacan los filtros y se funde en independientes anulando el rectificador nº4 , hasta que terminan . Se encuentra el fusible y el tiristor mal de Nº3 de la rama 3 . Despues de cambiarlos , se hace la prueba de pulsos y se ve que no llegan a los 3 tiristores activados por la fibra 2 , haciendo pruebas intercambiando las fibras , despues algunas veces fallaba la fibra 2 . Se localizan 2 fibras libres con conectores , marcadas como R4-3/1 y R4-3/2 . Se conectan y se comprueba que llegan pulsos a todos los tiristores . Se rearma y se arranca , posteriormente se quita de independientes y se meten los filtros',
            'HORNO ARCO 1', 'RECTIFICADORES', 'RECTIFICADOR 4', 'FUSIBLE 3 RAMA 3'
        ),
        (
            1104154, DATE '2013-01-23', 'noche', '2',
            true, 'AVERIA_ELECTRICA',
            'Avisan de que les marca fallo en los 4 rectificadores , vemos que ha salido alarma de bajo caudal de agua en inductancias . Estaba en marcha la bomba 2 y antes del fallo estaba la 1 y no esta disparado el magnetotermico . Vemos que el caudal es correcto , se quitan las alarmas y se rearma 30Kv . Cuando se pueda hay que comprobar el funcionamiento de la bomba 1',
            'HORNO ARCO 1', 'RECTIFICADORES', 'CENTRAL AGUA DESIONIZADA', 'BOMBA INDUCTANCIAS 1'
        ),
        (
            1116850, DATE '2013-02-18', 'manana', '2',
            true, 'AVERIA_ELECTRICA',
            'Se desconecta la alimentacion y se suelta el conector para trabajos mecanicos',
            'HORNO ARCO 2', 'LIMPIADOR P. ESCORIA', 'EQUIPO ELÉCTRICO', 'MANGUERA ELECTRICA ENROLLADOR'
        ),
        (
            1159499, DATE '2013-05-19', 'manana', '2',
            true, 'AVERIA_ELECTRICA',
            'Nos avisan de que no funciona la elevacion auxiliar , se habia quedado con la cesta colgada para cargar . Se prueba con el mando de reserva , pero no funciona . Se retira para que cargen con la grua 1 . Se encuentra disparado el termico 1Q84 ( alimentacion auxiliar elevacion II ) , se rearma y vuenve a disparar al momento de iniciar la maniobra . Se localiza el problema en la bobina del contactor 3K11 , que esta en corto . Se saca una bobina del almacen y se cambia . Queda en funcionamiento',
            'HORNO ELECTRICO', 'AB-02', 'ELEVACIÓN AUXILAR', 'MOTOR'
        )
)
INSERT INTO public.partes_trabajo (
    ot_origen, fecha, turno, grupo_responsable, hubo_parada, causa,
    trabajo_realizado, equipo_id, creado_por_usuario_id
)
SELECT m.ot_origen, m.fecha, m.turno, m.grupo_responsable, m.hubo_parada,
       m.causa, m.trabajo_realizado, e.id, NULL
FROM muestra AS m
JOIN public.equipos AS e
  ON e.centro = m.centro
 AND e.instalacion = m.instalacion
 AND e.maquina = m.maquina
 AND e.elemento = m.elemento
ON CONFLICT (ot_origen) DO NOTHING;

COMMIT;
