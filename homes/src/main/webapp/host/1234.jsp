<!DOCTYPE html>
<html>
<head>
    <style>
        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% {
                transform: translateY(0);
            }
            40% {
                transform: translateY(-30px);
            }
            60% {
                transform: translateY(-15px);
            }
        }
 
    
        .bouncing-ball {
            width: 50px;
            height: 50px;
            background-color: red;
            border-radius: 50%;
            animation-name: bounce;
            animation-duration: 2s;
            animation-timing-function: ease-in-out;
            animation-iteration-count: infinite;
        }
    @keyframes spin {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }

        .spinning {
            width: 100px;
            height: 100px;
            background-color: blue;
            animation: spin 2s linear infinite;
        }
    </style>
</head>
<body>
<%for(int i =0;i<99;i++){%>
    <div class="bouncing-ball"></div>
     <div class="spinning"></div>
      <div class="spinning"></div>
                <%
    }
    %>
</body>
</html>
