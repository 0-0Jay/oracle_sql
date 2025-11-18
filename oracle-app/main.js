const express = require("express");
const db = require("./db.js");
const cors = require("cors");
const app = express(); //웹서버기능
const port = 3000;

app.use(cors()); //cors원칙  CORS 허용 (프론트에서 요청 가능하게)
app.use(express.json()); // body-parser json 처리 / 바디에 오는 데이터
app.use(express.urlencoded()); // key = val&key=val&.....

//url : 실행함수 => 라우팅
app.get("/", (req, res) => {
  res.send(" / 호출됨");
});

app.get("/boards", async (req, res) => {
  //board 조회
  let connection; //변수선언
  try {
    connection = await db.getConnection();
    let result = await connection.execute(`select * from board  order by 1`); // 사용할 쿼리 넣어주기
    console.log(result.rows);
    //res.send("조회완료"); //send는 txt, html 형식으로 넣는걸로 보여줌
    res.json(result.rows);
  } catch (err) {
    console.log(err);
    res.send("예외발생");
  } finally {
    //정상 실행 또는 예외 발생
    if (connection) {
      await connection.close();
    }
  }
});

app.get("/board/:id", async (req, res) => {
  //req.params.id = URL 주소에 적힌 값을 변수로 받아오는 방식
  ///board/3 → req.params.id = 3
  console.log(req.params.id); //프론트가 URL에 직접 써서 보내는 값들 = params
  //board 단건 조회
  const searchId = req.params.id;
  let connection; //변수선언
  try {
    connection = await db.getConnection();
    let result = await connection.execute(
      `select * from board  where board_id=${searchId}`
    ); // 사용할 쿼리 넣어주기
    console.log(result.rows); //SELECT는 "행(row) 목록"을 가져오는 작업
    //res.send("조회완료"); //send는 txt, html 형식으로 넣는걸로 보여줌
    res.json(result.rows);
  } catch (err) {
    console.log(err);
    res.send("예외발생");
  } finally {
    if (connection) {
      await connection.close();
    }
  }
});

//글 등록
// app.get("/board/:title/:content/:author", async (req, res) => {
//   console.log(req.body);
//   const { title, content, author } = {
//     title: "title1",
//     content: "content1",
//     author: "user01",
//   }; //객체 구조분해
//   let connection; //변수선언
//   try {
//     connection = await db.getConnection();
//     let result = await connection.execute(
//       `insert into board(board_id,title, content, author)
//        values((select max(board_id) +1 from board),:title, :content,:author)`,
//       [title, content, author],
//       { autoCommit: true } //자동 커밋 시켜주는 거임
//     ); // 사용할 쿼리 넣어주기
//     //connection.commit(); //커밋
//     console.log(result.rows);
//     //res.send("조회완료"); //send는 txt, html 형식으로 넣는걸로 보여줌
//     res.json(result.rows);
//   } catch (err) {
//     console.log(err);
//     res.send("예외발생");
//   } finally {
//     //정상 실행 또는 예외 발생
//     if (connection) {
//       await connection.close();
//     }
//   }
// });
//글등록
//SELECT는 데이터 표(행/열)를 반환하기 때문에 result.rows가 있고,
//INSERT/UPDATE/DELETE는 데이터가 없고 성공 여부만 반환해서 rows가 없다.

app.post("/board", async (req, res) => {
  console.log(req.body); //post는 params가 아니고 body에 담아 요청
  const { title, content, author } = req.body; // 우리가 넘긴 값으로 처리하기 위해 (바디 값)
  //객체 구조분해
  console.log(title, content, author);
  let connection; //변수선언
  try {
    connection = await db.getConnection();
    let result = await connection.execute(
      `insert into board(board_id,title, content, author)
       values((select max(board_id) +1 from board), :title, :content, :author)`,
      [title, content, author],
      { autoCommit: true } //자동 커밋 시켜주는 거임
    ); // 사용할 쿼리 넣어주기
    //connection.commit(); //커밋
    console.log(result);
    //res.send("조회완료"); //send는 txt, html 형식으로 넣는걸로 보여줌
    res.json(result);
  } catch (err) {
    console.log(err);
    //res.send("예외발생");
  } finally {
    //정상 실행 또는 예외 발생
    if (connection) {
      await connection.close();
    }
  }
});

//글수정
app.put("/board", async (req, res) => {
  //글 수정 쿼리 작성
  const { title, content } = {
    title: "3번글입니다",
    content: "3번 글 내용입니단",
  }; // 우리가 넘긴 값으로 처리하기 위해 (바디 값)

  //객체 구조분해
  console.log(title, content);
  let connection; //변수선언
  try {
    connection = await db.getConnection();
    let result = await connection.execute(
      `update board
       set title = :title, content = :content 
       where board_id= 3`,
      [title, content],
      { autoCommit: true } //자동 커밋 시켜주는 거임
    ); // 사용할 쿼리 넣어주기
    //connection.commit(); //커밋
    console.log(result);
    //res.send("조회완료"); //send는 txt, html 형식으로 넣는걸로 보여줌
    res.json(result);
  } catch (err) {
    console.log(err);
    //res.send("예외발생");
  } finally {
    //정상 실행 또는 예외 발생
    if (connection) {
      await connection.close();
    }
  }
});

app.listen(port, () => {
  console.log(`Express 서버가 실행중...http://localhost:${port}`);
});
