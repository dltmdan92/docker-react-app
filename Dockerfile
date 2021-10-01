FROM node:alpine
WORKDIR '/usr/src/app'
COPY package.json .
RUN npm install
COPY ./ ./
RUN npm run build

FROM nginx
EXPOSE 80
COPY --from=0 /usr/src/app/build /usr/share/nginx/html

# 기존 Dockerfile에 있는 FROM node:alpine as builder 줄에서 as builder를 지워버리고 맨 밑 COPY줄의 --from=builder를 --from=0 으로 바꿔서 다시 시도하시면 아마도 될 것 같습니다.

# 이유는 Amazon Linux 2로 업그레이드 되면서 FROM절을 수행할때 인자를 1개만 받도록 변경된 것 같습니다. 그래서 as builder가 붙게 되면 인자가 3개가 되어서 오류를 뿜습니다. 따라서 as builder를 지워버리고 밑 from에서 별칭이 아닌 0번째 FROM를 뜻하도록 바꿔주게 되면 정상적으로 수행됩니다.
