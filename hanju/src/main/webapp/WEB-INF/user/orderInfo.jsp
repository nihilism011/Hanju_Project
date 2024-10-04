<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <link rel="stylesheet" href="../../css/userCss/orderInfo.css"/>
    <link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">
<script src="/js/jquery.js"></script>
<script src="/js/vue.js"></script>
    <title>document</title>
    <jsp:include page="../mainPage/header.jsp" flush="false" />
  </head>
  <body>
    <div id="app">
      <div id="container">
        <div id="contents">
          <div class="tit">
            <h2>주문조회</h2>
          </div>
            <div class="list">
              <h3>주문 상품 정보</h3>
            </div>
          <table>
            <tr>
                <th>주문일자</th>
                <th>상품</th>
                <th>수량</th>
                <th>주문금액</th>
                <th>상태</th>
            </tr>
            <tr v-for="item in orderList">
              <td class="cdatetime">
                <div>{{item.cDateTime}}</div>
              </td>
                <td class="product">
                    <div class="productInfo">
                      <a @click="fnDetailPage(item.sellId,item.kind)" class="thum"><img :src="item.filePath"></a>
                      <span>
                        <a @click="fnDetailPage(item.sellId,item.kind)" class="productName">{{item.productName}}</a>
                      </span>
                    </div>
                </td>
                <td class="cnt">
                    <div>{{item.productCount}}</div>
                </td>
                <td class="price">
                  <div>{{item.price}}</div>
              </td>
              <td class="state">
                <div v-if="item.status == 'B'">결제완료</div>
                <div v-else-if="item.status == 'S'">배송중</div>
                <div v-else-if="item.status == 'C'">배송완료</div>
                <div v-else>조회불가</div>
            </td>
            </tr>
          </table>
          <div class="pagination">
            <button v-if="currentPage > 1">이전</button>
            <button v-for="page in totalPages" :class="{active: page == currentPage}">
                {{ page }}
            </button>
            <button v-if="currentPage < totalPages">다음</button>
        </div>
        </div>
      </div>
    </div>
    <jsp:include page="../mainPage/footer.jsp"></jsp:include>
  </body>
</html>
<script>
  const app = Vue.createApp({
    data() {
      return {
        orderList:[],
        currentPage: 1,      
        pageSize: 5,        
        totalPages: 2 
      };
    },
    methods: {
      fnOrder(){
        var self = this;
				
				$.ajax({
					url:"getOrderList.dox", 
					dataType:"json",	
					type : "GET", 
				
					success : function(data) {  
						console.log(data);
						self.orderList = data.orderList;
            console.log(self.orderList);
					}
				});
      },

      fnDetailPage(productId,kind) {
        if(kind == 'P'){
        location.href = `/details/detailsPickup.do?id=\${productId}`;
      }else if(kind == 'N'){
          location.href = `/details/details.do?id=\${productId}`;
        }
      }
    },
    mounted() {
      this.fnOrder();
    },
  });
  app.mount("#app");
</script>