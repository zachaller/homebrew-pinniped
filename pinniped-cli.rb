class PinnipedCli < Formula
    desc "Pinniped CLI for Kubernetes cluster authentication"
    homepage "https://pinniped.dev/"
    url "https://github.com/zachaller/pinniped",
        tag:      "v0.7.0",
        revision: "528459573ae1f4b3e489750f74a866666e4c9487"
    license "Apache-2.0"
    head "https://github.com/zachaller/pinniped", branch: "main"
    
    depends_on "go" => :build
    depends_on "libtool"
  
    def install
      rm_rf ".brew_home"
      unless version.to_s.include? "HEAD"
        ENV["KUBE_GIT_VERSION"] = "v#{version.to_s}" 
      end 
      system "go build -o #{bin}/pinniped -ldflags \"$(hack/get-ldflags.sh)\" cmd/pinniped/main.go"
    end
  
    test do
      run_output = shell_output("#{bin}/pinniped")
      assert_match "pinniped is the client-side binary for use with Pinniped-enabled Kubernetes clusters.", run_output
    end
  end
