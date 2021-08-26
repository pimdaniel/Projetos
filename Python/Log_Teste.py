import logging
#logging.basicConfig(filename='example.log', encoding='utf-8', level=logging.DEBUG)

# logger = logging.getLogger('../Bloqueia_usuarios')

logging.basicConfig(filename='../example.log', format='%()  %(levelname)s:%(asctime)s:%(message)s',filemode='a', level=logging.DEBUG)


logging.debug('This message should go to the log file')
logging.info('So should this')
logging.warning('And this, too')
logging.error('And non-ASCII stuff, too, like Øresund and Malmö')


_v1 = "dddddd"
_v2="xxxxxx"
logging.warning('%s before you %s', _v1, _v2)
