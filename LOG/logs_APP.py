import logging
import sys 
sys.path.append("../")
from DAL import crypDAL as cr



log_format = '%(asctime)s:%(levelname)s:%(filename)s:%(message)s:%(name)s'

def logDatabase():

    _file = '../logDatabases.log'
    logging.basicConfig(filename=_file,
                    # w -> sobrescreve o arquivo a cada log
                    # a -> não sobrescreve o arquivo
                    filemode='a',
                    level=logging.DEBUG,
                    format=log_format)
    logger = logging.getLogger('SQLSERVER')
    return  logger,_file


def logAPagaUsuario():
    
    _file = '../logAPagaUsuario.log'
    logging.basicConfig(filename=_file,
                    # w -> sobrescreve o arquivo a cada log
                    # a -> não sobrescreve o arquivo
                    filemode='a',
                    level=logging.DEBUG,
                    format=log_format)
    logger = logging.getLogger('logAPagaUsuario')
    return  logger,_file 