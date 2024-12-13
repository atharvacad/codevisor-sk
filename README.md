
# CodeVisor
CodeVisor is a web application that takes a program from the user and generates a flowchart.

In the past few years, generative AI tools have helped us considerably to digest other people's code and improve our own code. Despite their linguistic versatility, their visual skills are relatively primitive, and we're worried that the more visually inclined are being left out in the race to achieve general artificial intelligence. That's why we wanted to design a developer-oriented alternative to tools like ChatGPT to bring these folks "back in the loop".

We architected CodeVisor with familiar websites like CodePen and JSFiddle in mind—to be simple and to-the-point. CodeVisor presents the user with two panes—the code pane and the preview pane—that enable them to submit code they'd like to be explained visually. The user clicks "Generate", which populates the preview pane with a (mostly) code-free flowchart that traces through the execution of the program. CodeVisor takes advantage of exclusively visual cues like color, shape, space, and placement, to communicate the story the program conveys in an easily accessible format.

We began by experimenting with different pipelines, first asking GPT to generate an image with DALL-E, then asking it to write LaTeX code, and eventually settling on a format called Graphviz that produced the kind of high-accuracy flowcharts we were satisfied with. In its final iteration, the product feeds the user's code to GPT, requesting a Graphviz file containing the nodes, edges, and styles that comprise the end-result. Graphviz offered many advantages for us, since the format is straightforward for GPT to understand and gives it less control over complicated typesetting features that it's likely to misapply.


## Demo

https://www.youtube.com/watch?v=jiijgr1a--A&t=52s&ab_channel=JadenPeterson


## Authors

- [@jadenPete](https://github.com/jadenPete)
- [@aravinds13](https://github.com/aravinds13)
- [@shreyash0k](https://github.com/shreyash0k/)

## Building and Running with Docker

This project uses Docker to containerize the frontend and backend services. Follow the steps below to build and run the project using Docker and Docker Compose.

### Prerequisites

- Docker: [Install Docker](https://docs.docker.com/get-docker/)
- Docker Compose: [Install Docker Compose](https://docs.docker.com/compose/install/)

### Steps

1. Clone the repository:

    ```sh
    git clone https://github.com/atharvacad/codevisor-sk.git
    cd codevisor-sk
    ```

2. Update the `docker-compose.yaml` file with your environment variables. The database details are already configured to be hosted locally on a Docker container. You only need to provide your OpenAI API key:
    ```yaml
    version: '3'
    services:
      database:
        build: ./database
        ports:
          - "27017:27017"
        volumes:
          - ./database/data:/data/db

      backend:
        build: ./backend
        ports:
          - "3000:3000"
        environment:
          - MONGODB_URL=mongodb://database:27017/projects_db
          - MONGODB_DATABASE_NAME=projects_db
          - MONGODB_COLLECTION_NAME=projects
          - OPENAI_AUTH=your_openai_api_key
        depends_on:
          - database

      frontend:
        build: ./frontend/codevisor
        ports:
          - "80:80"
        depends_on:
          - backend
    ```

3. Build and run the Docker containers using Docker Compose:

    ```sh
    docker-compose up --build
    ```

4. Access the frontend application in your browser at `http://localhost`.

### Docker Files

- **Backend Dockerfile**: [backend/dockerfile](backend/dockerfile)
- **Frontend Dockerfile**: [frontend/codevisor/dockerfile](frontend/codevisor/dockerfile)
- **Docker Compose File**: [docker-compose.yaml](docker-compose.yaml)

### Docker Files

- **Backend Dockerfile**: [backend/dockerfile](backend/dockerfile)
- **Frontend Dockerfile**: [frontend/codevisor/dockerfile](frontend/codevisor/dockerfile)
- **Database Dockerfile**: [database/Dockerfile](database/Dockerfile)
- **Docker Compose File**: [docker-compose.yaml](docker-compose.yaml)

### Detailed Docker Setup

#### Backend Service

The backend service is built using Node.js and TypeScript. It includes the following steps:

1. **Base Image**: Uses the official Node.js image.
2. **Working Directory**: Sets the working directory to `/app`.
3. **Dependencies**: Copies `package.json` and `tsconfig.json`, installs dependencies, and installs Graphviz.
4. **Build**: Copies the backend code and builds the TypeScript code.
5. **Expose Port**: Exposes port 3000.
6. **Command**: Sets the default command to run the backend server.

#### Frontend Service

The frontend service is built using Angular. It includes the following steps:

1. **Base Image**: Uses the official Node.js image for building and Nginx for serving.
2. **Working Directory**: Sets the working directory to `/frontend/codevisor`.
3. **Dependencies**: Copies `package.json`, installs dependencies, and installs Angular CLI.
4. **Build**: Copies the frontend code and builds the Angular application.
5. **Serve**: Uses Nginx to serve the built application.

#### Database Service

The database service uses MongoDB. It includes the following steps:

1. **Base Image**: Uses the official MongoDB image.
2. **Working Directory**: Sets the working directory to `/data`.
3. **Data Import**: Copies the JSON data file and initialization scripts.
4. **Expose Port**: Exposes port 27017.

### Environment Variables

- `MONGODB_URL`: The MongoDB connection URL.
- `MONGODB_DATABASE_NAME`: The name of the MongoDB database.
- `MONGODB_COLLECTION_NAME`: The name of the MongoDB collection.
- `OPENAI_AUTH`: Your OpenAI API key.