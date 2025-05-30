<%@ include file="header.jsp" %>
<div class="container-fluid">
  <div class="row">
    <%-- Sidebar pour les dashboards uniquement --%>
    <% if (request.getRequestURI().contains("dashboard")) { %>
      <div class="col-md-2">
        <%@ include file="sidebar.jsp" %>
      </div>
      <div class="col-md-10 bg-danger">

      </div>
    <% } else { %>
      <div class="col-md-12 bg-success">
      </div>
    <% } %>
  </div>
</div>
<%@ include file="footer.jsp" %>
