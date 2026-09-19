\# Infraestrutura TechNova — Aula 04



\## Descrição



Este projeto implementa a infraestrutura da aplicação \*\*TechNova API\*\* utilizando \*\*Terraform\*\* na AWS.



A infraestrutura foi criada com uma VPC própria, subnets públicas e privadas distribuídas em duas Availability Zones, Internet Gateway, tabelas de rotas, Security Groups, uma instância EC2 para execução da API Node.js e integração com IAM.



A API utilizada no projeto está disponível no repositório:



`https://github.com/Pablao02/technova-api`



\---



\## Arquitetura



```text

&#x20;                        INTERNET

&#x20;                            |

&#x20;                            |

&#x20;                   +----------------+

&#x20;                   | Internet       |

&#x20;                   | Gateway        |

&#x20;                   +-------+--------+

&#x20;                           |

&#x20;                   +-------+--------+

&#x20;                   | VPC            |

&#x20;                   | 10.0.0.0/16    |

&#x20;                   +-------+--------+

&#x20;                           |

&#x20;             +-------------+-------------+

&#x20;             |                           |

&#x20;       Availability Zone 1         Availability Zone 2

&#x20;             |                           |

&#x20;     +-------+-------+           +-------+-------+

&#x20;     | Public Subnet |           | Public Subnet |

&#x20;     | 10.0.1.0/24   |           | 10.0.3.0/24   |

&#x20;     |               |           |               |

&#x20;     | EC2 API       |           |               |

&#x20;     +---------------+           +---------------+

&#x20;             |                           |

&#x20;     +-------+-------+           +-------+-------+

&#x20;     | Private Subnet|           | Private Subnet|

&#x20;     | 10.0.2.0/24   |           | 10.0.4.0/24   |

&#x20;     |               |           |               |

&#x20;     | DB futuro     |           | DB futuro     |

&#x20;     +---------------+           +---------------+

```



\---



\## Recursos cri



