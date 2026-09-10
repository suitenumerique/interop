# Implementation reference

## Rules of the Interop-Club

- **Do not** talk about the interop-club.
- All applications run locally within the same **Docker network** (`lasuite`).
- Each application must have its own dedicated instances (mapped to a reserved
  host port when required) for the following services: PostgreSQL, Nginx.
- Each specific service is namespaced by the application name (e.g.,
  `drive-frontend`, `drive-backend`) and mapped to a reserved host port.
- Auxiliary services (e.g., Redis, Mailcatcher, Crowdin, Node, MinIO, etc.) can
  be centralized (for MinIO, buckets must be namespaced by the application
  name, e.g., `conversations/my-bucket`).
- A single instance of **Keycloak** with its dedicated database must be
  launched, with all applications of the suite defined in its realm with their
  client ID and secret.

## Reference

Services that expose host ports must be restricted to **localhost** for
security reasons.

| Application               | Service                        | URL                                                                                                           | Container Port     | Host Port             |
| ------------------------- | ------------------------------ | ------------------------------------------------------------------------------------------------------------- | ------------------ | --------------------- |
| *                         | mailcatcher                    | [mailcatcher.lasuite.localhost:48000](http://mailcatcher.lasuite.localhost:48000)                             | 1080               | 48000                 |
|                           | minio                          | [minio.lasuite.localhost:48001](http://minio.lasuite.localhost:48001)                                         | 9000 / 9001        | 48001 / 8002          |
|                           | crowdin                        | -                                                                                                             | -                  | -                     |
|                           | keycloak-postgresql            | -                                                                                                             | 5432               | 48003                 |
|                           | keycloak                       | [keycloak.lasuite.localhost:48004](http://keycloak.lasuite.localhost:48004)                                   | 8080               | 48004                 |
|                           | redis                          | -                                                                                                             | 6379               | 48005                 |
| **Docs**                  |                                |                                                                                                               |                    | **481xx**             |
|                           | docs-backend                   | [docs.lasuite.localhost:48100](http://docs.lasuite.localhost:48100)                                           | 8000               | 48100                 |
|                           | docs-celery                    | -                                                                                                             | -                  | -                     |
|                           | docs-postgresql                | -                                                                                                             | 5432               | _48101_               |
|                           | docs-nginx                     | [docs.lasuite.localhost:48102](http://docs.lasuite.localhost:48102)                                           | 8083               | 48102                 |
|                           | docs-nginx-frontend            | [docs.lasuite.localhost:48103](http://docs.lasuite.localhost:48103)                                           | 3000               | 48103                 |
|                           | docs-frontend                  | [docs.lasuite.localhost:48104](http://docs.lasuite.localhost:48104)                                           | 3000               | 48104                 |
|                           | y-provider                     | -                                                                                                             | 4444               | _48105_               |
|                           | y-provider-converter           | -                                                                                                             | -                  | -                     |
|                           | docspec                        | -                                                                                                             | 4000               | _48106_               |
| **Fichiers**              |                                |                                                                                                               |                    | **482xx**             |
|                           | drive-backend                  | [drive.lasuite.localhost:48200](http://drive.lasuite.localhost:48200)                                         | 8000               | 48200                 |
|                           | drive-celery                   | -                                                                                                             | -                  | -                     |
|                           | drive-postgresql               | -                                                                                                             | 5432               | _48201_               |
|                           | drive-nginx                    | [drive.lasuite.localhost:48202](http://drive.lasuite.localhost:48202)                                         | 8083               | 48202                 |
|                           | drive-frontend                 | [drive.lasuite.localhost:48203](http://drive.lasuite.localhost:48203)                                         | 3000               | 48203                 |
|                           | drive-node                     | -                                                                                                             | -                  | -                     |
|                           | ds-proxy                       | -                                                                                                             | 4444               | _48204_               |
|                           | collabora                      | -                                                                                                             | 9980               | _48205_               |
|                           | onlyoffice                     | -                                                                                                             | 80                 | _48206_               |
| **Visio**                 |                                |                                                                                                               |                    | **483xx**             |
|                           | meet-backend                   | [meet.lasuite.localhost:48300](http://meet.lasuite.localhost:48300)                                           | 8000               | 48300                 |
|                           | meet-celery                    | -                                                                                                             | -                  | -                     |
|                           | meet-postgresql                | -                                                                                                             | 5432               | _48301_               |
|                           | meet-nginx                     | [meet.lasuite.localhost:48302](http://meet.lasuite.localhost:48302)                                           | 8083               | 48302                 |
|                           | meet-frontend                  | [meet.lasuite.localhost:48303](http://meet.lasuite.localhost:48303)                                           | 8080               | 48303                 |
|                           | livekit                        | -                                                                                                             | 7880 / 7881 / 7882 | 48304 / 48305 / 48306 |
|                           | livekit-egress                 | -                                                                                                             | -                  | -                     |
|                           | metadata-collector             | -                                                                                                             | -                  | -                     |
|                           | multi-user-transcriber         | -                                                                                                             | -                  | -                     |
|                           | meet-summary                   | [meet.lasuite.localhost:48307](http://meet.lasuite.localhost:48307)                                           | 8000               | 48307                 |
|                           | meet-summary-celery-transcribe | -                                                                                                             | -                  | -                     |
|                           | meet-summary-celery-summarize  | -                                                                                                             | -                  | -                     |
| **Assistant Transcripts** |                                |                                                                                                               |                    | **484xx**             |
|                           | transcript-backend             | [transcript.lasuite.localhost:48400](http://transcript.lasuite.localhost:48400)                               | 8000               | 48400                 |
|                           | transcript-celery              | -                                                                                                             | -                  | -                     |
|                           | transcript-celery-audio        | -                                                                                                             | -                  | -                     |
|                           | transcript-postgresql          | -                                                                                                             | 5432               | _48401_               |
|                           | transcript-nginx               | [transcript.lasuite.localhost:48402](http://transcript.lasuite.localhost:48402)                               | 8083               | 48402                 |
|                           | transcript-frontend            | [transcript.lasuite.localhost:48403](http://transcript.lasuite.localhost:48403)                               | 8080               | 48403                 |
| **Assistant IA**          |                                |                                                                                                               |                    | **485xx**             |
|                           | conversations-backend          | [conversations.lasuite.localhost:48500](http://conversations.lasuite.localhost:48500)                         | 8000               | 48500                 |
|                           | conversations-celery           | -                                                                                                             | -                  | -                     |
|                           | conversations-postgresql       | -                                                                                                             | 5432               | _48501_               |
|                           | conversations-nginx            | [conversations.lasuite.localhost:48502](http://conversations.lasuite.localhost:48502)                         | 8083               | 48502                 |
|                           | conversations-frontend         | [conversations.lasuite.localhost:48503](http://conversations.lasuite.localhost:48503)                         | 3000               | 48503                 |
| **Mon Compte**            |                                |                                                                                                               |                    | **486xx**             |
|                           | accounts-backend               | [accounts.lasuite.localhost:48600](http://accounts.lasuite.localhost:48600)                                   | 9901               | 48600                 |
|                           | accounts-postgresql            | -                                                                                                             | 5432               | _48601_               |
|                           | accounts-nginx                 | [accounts.lasuite.localhost:48602](http://accounts.lasuite.localhost:48602)                                   | 9903               | 48602                 |
|                           | accounts-frontend              | [accounts.lasuite.localhost:48603](http://accounts.lasuite.localhost:48603)                                   | 9900               | 48603                 |
| **Le Hub**                |                                |                                                                                                               |                    | **487xx**             |
|                           | hub-backend                    | [hub.lasuite.localhost:48700](http://hub.lasuite.localhost:48700)                                             | 8000               | 48700                 |
|                           | hub-postgresql                 | -                                                                                                             | 5432               | _48701_               |
|                           | hub-nginx                      | [hub.lasuite.localhost:48702](http://hub.lasuite.localhost:48702)                                             | 9803               | 48702                 |
|                           | hub-frontend                   | [hub.lasuite.localhost:48703](http://hub.lasuite.localhost:48703)                                             | 9800               | 48703                 |
| **La Régie**              |                                |                                                                                                               |                    | **488xx**             |
|                           | people-backend                 | [people.lasuite.localhost:48800](http://people.lasuite.localhost:48800)                                       | 8000               | 48800                 |
|                           | people-celery                  | -                                                                                                             | -                  | -                     |
|                           | people-celery-beat             | -                                                                                                             | -                  | -                     |
|                           | people-flower                  | [people.lasuite.localhost:48801](http://people.lasuite.localhost:48801)                                       | 5555               | 48801                 |
|                           | people-postgresql              | -                                                                                                             | 5432               | _48802_               |
|                           | people-nginx                   | [people.lasuite.localhost:48803](http://people.lasuite.localhost:48803)                                       | 8083               | 48803                 |
|                           | people-frontend                | [people.lasuite.localhost:48804](http://people.lasuite.localhost:48804)                                       | 3000               | 48804                 |
|                           | dimail-api                     | [api.dimail.lasuite.localhost:48805](http://api.dimail.lasuite.localhost:48805)                               | 8000               | 48805                 |
| **Drive-migrator**        |                                |                                                                                                               |                    | **489xx**             |
|                           | migrator-backend               | [migrator.lasuite.localhost:48900](http://migrator.lasuite.localhost:48900)                                   | 8000               | 48900                 |
|                           | migrator-celery                | -                                                                                                             | -                  | -                     |
|                           | migrator-flower                | [migrator.lasuite.localhost:48901](http://migrator.lasuite.localhost:48901)                                   | 5555               | 48901                 |
|                           | migrator-postgresql            | -                                                                                                             | 5432               | _48902_               |
|                           | migrator-nginx                 | [migrator.lasuite.localhost:48903](http://migrator.lasuite.localhost:48903)                                   | 8083               | 48903                 |
|                           | migrator-frontend              | [migrator.lasuite.localhost:48904](http://migrator.lasuite.localhost:48904)                                   | 3000               | 48904                 |
| **Menshen**               |                                |                                                                                                               |                    | **490xx**             |
|                           | menshen-backend                | [menshen.lasuite.localhost:49000](http://menshen.lasuite.localhost:49000)                                     | 8000               | 49000                 |
|                           | menshen-postgresql             | -                                                                                                             | 5432               | 49001                 |
|                           | menshen-playground-source      | [source.playground.menshen.lasuite.localhost:49002](http://source.playground.menshen.lasuite.localhost:49002) | 8000               | 49002                 |
|                           | menshen-playground-target      | [source.playground.menshen.lasuite.localhost:49003](http://source.playground.menshen.lasuite.localhost:49003) | 8000               | 49003                 |
| **Find**                  |                                |                                                                                                               |                    | **491xx**             |
|                           | find-backend                   | [find.lasuite.localhost:49100](http://find.lasuite.localhost:49100)                                           | 8000               | 49100                 |
|                           | find-celery                    | -                                                                                                             | -                  | -                     |
|                           | find-postgresql                | -                                                                                                             | 5432               | _49101_               |
|                           | opensearch                     | [opensearch.find.lasuite.localhost:49102](http://opensearch.find.lasuite.localhost:49102)                     | 9200 / 9600        | _49102_ / _49103_     |
|                           | opensearch-dashboards          | [dashboards.find.lasuite.localhost:49104](http://dashboards.find.lasuite.localhost:49104)                     | 5601               | 49104                 |
| **Grist**                 |                                |                                                                                                               |                    | **492xx**             |
| **Messagerie**            |                                |                                                                                                               |                    | **493xx**             |

**Note:** Host ports in _italics_ are optional and depend on your development
habits, as the service is reachable from the Docker network `lasuite`.
