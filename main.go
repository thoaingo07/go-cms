package main

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

func main() {
	server := gin.Default()
	server.LoadHTMLGlob("templates/**/*.html")
	// Routes
	server.GET("/", func(c *gin.Context) {
		c.HTML(http.StatusOK, "pages/index.html", gin.H{
			"title": "Go Cms",
			"blogs": blogs,
		})
	})
	server.GET("/blogs", getBlogs)
	//server.GET("/blogs/:id:/:name", getBlogs)

	// Start server
	server.Run(":8080")
}

var blogs = []Blog{
	{Id: 1, Title: "Thoai Ngo - Full Stack Blog"},
	{Id: 2, Title: "Andy Book Store"},
}

func getBlogs(c *gin.Context) {
	// resp := ActionResp{
	// 	Code:    "success",
	// 	Success: true,
	// 	Data:    blogs,
	// }
	// c.IndentedJSON(http.StatusOK, resp)
	c.HTML(http.StatusOK, "pages/blogs.html", gin.H{
		"title": "Go Cms",
		"blogs": blogs,
	})
}

type ActionResp struct {
	Code    string            `json:"code"`
	Success bool              `json:"success"`
	Data    interface{}       `json:"data"`
	Errors  []ValidationError `json:"errors"`
}
type ValidationError struct {
	Property string
	Error    string
}

type Blog struct {
	Id    int    `json:"id"`
	Title string `json:"title"`
}
